extends KinematicBody2D

onready var Player = get_parent().get_node("Player")

const BULLET = preload("res://Scenes/EnemyBullet.tscn")

const GRAVITY = 1000
const SPEED = 50
const JUMP_SPEED = 270
const FLOOR = Vector2(0, -1)

var velocity = Vector2()

var direction = 1 #here 1 represents right for convenience
var is_dead = false
var lives = 2
var damage = 1

var player_in_range = true
var can_shoot = true

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if !player_in_range:
		if !is_dead:
			velocity.x = SPEED * direction
			#velocity. y +- GRAVITY
			velocity.y += GRAVITY * delta
	
			velocity = move_and_slide(velocity, FLOOR)
	
		if is_on_wall():
			direction = direction * -1 #inverts the direction when it collides with a wall
			$LedgeRayCast.position.x *= -1
	
		#RAYCAST FOR MANAGING LEDGES
		if $LedgeRayCast.is_colliding() == false:
			direction = direction * -1
			$LedgeRayCast.position.x *= -1
	
	else:
		follow_player()
		velocity = move_and_slide(velocity, FLOOR)
		velocity.y += GRAVITY * delta
		shoot()
		if is_on_wall() && is_on_floor():
			jump()
		

func follow_player():
	if Player.position.x < position.x:
		velocity.x = -SPEED
	if Player.position.x > position.x:
		velocity.x = SPEED
	
func jump():
		velocity.y -= JUMP_SPEED
	
func shoot():
	if can_shoot == true && player_in_range:
		var bullet = BULLET.instance()
		bullet.damage = damage
		if sign($BulletSpawn.position.x) == 1:
			bullet.set_bullet_direction(1)
		else:
			bullet.set_bullet_direction(-1)
		get_parent().add_child(bullet)
		bullet.position = $BulletSpawn.global_position
		
		can_shoot = false
		$ShootDelay.start()
	
	
func hurt(damage):
	velocity = Vector2(0,0)
	velocity.y -= JUMP_SPEED * 0.6  # multiplying just so it won't jump so high 
	lives -= damage
	if lives <= 0:
		queue_free()
		
#TODO Fazer animação de morte e delay dos corpos antes de sumir (se der tempo)
# Vídeo 9 da série UmaiPixel
	


func _on_ShootDelay_timeout():
	can_shoot = true
