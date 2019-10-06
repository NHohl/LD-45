extends KinematicBody2D

onready var Player = get_parent().get_node("Player")

const BULLET = preload("res://Scenes/EnemyBullet.tscn")

const GRAVITY = 1000
const SPEED = 50
const JUMP_SPEED = 270
const UP = Vector2(0, -1)

var velocity = Vector2()

var direction = 1 #here 1 represents right for convenience
var is_dead = false
var lives = 2
var damage = 0

var player_in_range = false
var can_shoot = true

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity = move_and_slide(velocity, UP)
	velocity.y += GRAVITY * delta
	
	if !player_in_range:
		#walk_to_sides()
		#velocity = move_and_slide(velocity, UP)
	
		if is_on_wall():
			direction = direction * -1 #inverts the direction when it collides with a wall
			$LedgeRayCast.position.x *= -1
		
	
	else:
		follow_player()
		shoot()
		

func follow_player():
	if Player.position.x < position.x:
		velocity.x = -SPEED
		$BulletSpawn.position.x = -1
		
	if Player.position.x > position.x:
		velocity.x = SPEED
		$BulletSpawn.position.x = 1
			
	if Player.position.y < position.y - 24:
		if is_on_floor():
			jump()
	
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
	
func walk_to_sides():
	if !is_dead:
		velocity.x = SPEED * direction
		#velocity. y +- GRAVITY
		
	#RAYCAST FOR MANAGING LEDGES
	if $LedgeRayCast.is_colliding() == false:
		direction = direction * -1
		$LedgeRayCast.position.x *= -1
	
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


func _on_Detector_body_entered(body):
	if body.name == "Player":
		player_in_range = true
		print("entered")
		
func _on_Detector_body_exited(body):
	if body.name == "Player":
		player_in_range = false
		print("exited")
		
