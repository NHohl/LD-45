extends KinematicBody2D

const SPEED = 100
const GRAVITY = 1000
const JUMP_SPEED = 270
const UP = Vector2(0, -1)
const WORLD_LIMIT = 4000

const BULLET = preload("res://Scenes/Bullet.tscn")

export var lives = 99
var can_shoot = true

var damage = 2

signal update_hud
#signal animate

var motion = Vector2(0,0)
var on_floor #used in the animation signal

func _ready():
	pass

func _process(delta): #controls motion coming from input
	move()
	jump()
	manage_restart()
	godmode()

func _physics_process(delta): #controls motion coming from the engine
	apply_gravity(delta)
	move()
	jump() #needs to be after apply gravity
	motion = move_and_slide(motion, UP)
	on_floor = is_on_floor()
	#animate()
	shoot()
	
	
func move():
	if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("right"):
		motion.x = -SPEED
		if sign($BulletSpawn.position.x) == 1:
			$BulletSpawn.position.x *= -1
	elif Input.is_action_pressed("ui_right") and not Input.is_action_pressed("left"):
		motion.x = SPEED
		if sign($BulletSpawn.position.x) == -1:
			$BulletSpawn.position.x *= -1
	else:
		motion.x = 0

func jump():
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		motion.y -= JUMP_SPEED

func apply_gravity(delta):
#	if not is_on_floor():
#		motion.y += GRAVITY * delta
#	elif is_on_ceiling():
#		motion.y = 100
#		print(is_on_ceiling())
#		print(motion.y)
#		#motion.y += GRAVITY
#	else:
	if position.y > WORLD_LIMIT:
		end_game()
	else:
		motion.y += GRAVITY * delta #constantly falling so it's always on floor and is able to jump

func shoot():
	if can_shoot && GLOBAL.PLAYER_LEVEL > 0:
		if Input.is_action_just_pressed("shoot"):
			var bullet = BULLET.instance()
			bullet.damage = GLOBAL.PLAYER_DAMAGE
			if sign($BulletSpawn.position.x) == 1:
				bullet.set_bullet_direction(1)
			else:
				bullet.set_bullet_direction(-1)
			get_parent().add_child(bullet)
			bullet.position = $BulletSpawn.global_position

func animate():
	emit_signal("animate", motion, on_floor)
	
func godmode():
	if Input.is_action_just_pressed("ui_accept"):
		print("God Mode ON")
		GLOBAL.PLAYER_LIFE = 9999

func end_game():
	reset_stats()
	get_tree().change_scene("res://Scenes/Level.tscn")
	
func hurt(damage):
	#motion.y = 0
	#motion.y -= JUMP_SPEED * 0.6  # multiplying just so it won't jump so high 
	GLOBAL.PLAYER_LIFE -= damage
	emit_signal("update_hud")
#	print("player n of lifes = ", GLOBAL.PLAYER_LIFE)
	if GLOBAL.PLAYER_LIFE <= 0:
		reset_stats()
		end_game()
		
	
func manage_restart():
	if Input.is_action_just_pressed("Restart"):
		get_tree().reload_current_scene() 

func reset_stats():
	GLOBAL.PLAYER_DAMAGE = 0
	GLOBAL.PLAYER_LEVEL = 0
	GLOBAL.PLAYER_LIFE = 1
	GLOBAL.PLAYER_MONEY = 0
	GLOBAL.LEVEL_COST = 1
	GLOBAL.MAX_LIFE = 1
	GLOBAL.ENEMY_MONEY = 0
	GLOBAL.ENEMY_DELAY = 10
	GLOBAL.ENEMY_DAMAGE = 1
	GLOBAL.ENEMY_LEVEL = 0
	GLOBAL.ENEMY_LEVEL_COST = 3

func _on_Shop_player_level_up():
	$PlayerManager.pick_current_sprite()
	$PlayerManager.change_sprite()
