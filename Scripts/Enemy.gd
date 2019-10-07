extends KinematicBody2D

onready var Player = get_parent().get_node("Player")
onready var enemy0

const BULLET = preload("res://Scenes/EnemyBullet.tscn")

const GRAVITY = 1000
const SPEED = 30
const JUMP_SPEED = 270
const UP = Vector2(0, -1)

var velocity = Vector2()

var direction = 1 #here 1 represents right for convenience
var is_dead = false
var lives = 2
var damage
var shoot_delay

var player_in_range = false
var can_shoot = false
var can_jump = true

var current_texture

func _ready():
	$JumpDelay.wait_time = 1
	$ShootDelay.wait_time = shoot_delay
	$JumpDelay.start()
	$ShootDelay.start()
	pick_current_sprite()

func _physics_process(delta):
	velocity = move_and_slide(velocity, UP)
	velocity.y += GRAVITY * delta
	
	follow_player()
	shoot()
	jump_with_player()
	detect_wall()

func follow_player():
	if Player.position.x < position.x:
		velocity.x = -SPEED
		$BulletSpawn.position.x = -1
		
	if Player.position.x > position.x:
		velocity.x = SPEED
		$BulletSpawn.position.x = 1
			
func jump_with_player():
	if player_in_range:
		if Player.position.y < position.y - 24:
			jump()
	
func jump():
	if is_on_floor() && can_jump:
		velocity.y -= JUMP_SPEED
		#$JumpDelay.start()
		can_jump = false
	
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

		
		
func detect_wall():
	if $WallRayCastRight.is_colliding() == true:
		jump()
		#$WallRayCast.position.x *= -1
	if $WallRayCastLeft.is_colliding() == true:
		jump()
		#$WallRayCast.position.x *= -1
		
	
func hurt(damage):
	velocity = Vector2(0,0)
	velocity.y -= JUMP_SPEED * 0.6  # multiplying just so it won't jump so high 
	lives -= damage
	if lives <= 0:
		queue_free()
		
#TODO Fazer animação de morte e delay dos corpos antes de sumir (se der tempo)
# Vídeo 9 da série UmaiPixel

func pick_current_sprite():
	if GLOBAL.ENEMY_LEVEL == 0:
		current_texture = load("res://Sprites/EnemySprites/enemy0.png")
		$Sprite.set_texture(current_texture)
	if GLOBAL.ENEMY_LEVEL == 1:
		current_texture = load("res://Sprites/EnemySprites/enemy1.png")
		$Sprite.set_texture(current_texture)
	if GLOBAL.ENEMY_LEVEL == 2:
		current_texture = load("res://Sprites/EnemySprites/enemy2.png")
		$Sprite.set_texture(current_texture)
	if GLOBAL.ENEMY_LEVEL == 3:
		current_texture = load("res://Sprites/EnemySprites/enemy3.png")
		$Sprite.set_texture(current_texture)
	


func _on_ShootDelay_timeout():
	can_shoot = true


func _on_Detector_body_entered(body):
	if body.name == "Player":
		player_in_range = true
		
func _on_Detector_body_exited(body):
	if body.name == "Player":
		player_in_range = false
		


func _on_JumpDelay_timeout():
	can_jump = true
	