extends KinematicBody2D

const SPEED = 100
const GRAVITY = 1000
const JUMP_SPEED = 270
const UP = Vector2(0, -1)
const WORLD_LIMIT = 4000

const BULLET = preload("res://Scenes/Bullet.tscn")

var lives = 3
var can_shoot = true

var damage = 2

#signal animate

var motion = Vector2(0,0)
var on_floor #used in the animation signal

func _process(delta): #controls motion coming from input
	move()
	jump()
	manage_restart()

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
	if can_shoot == true && Input.is_action_just_pressed("shoot"):
		var bullet = BULLET.instance()
		bullet.damage = damage
		if sign($BulletSpawn.position.x) == 1:
			bullet.set_bullet_direction(1)
		else:
			bullet.set_bullet_direction(-1)
		get_parent().add_child(bullet)
		bullet.position = $BulletSpawn.global_position

func animate():
	emit_signal("animate", motion, on_floor)

func end_game():
	get_tree().change_scene("res://Scenes/Level.tscn")
	
func hurt(damage):
	motion.y = 0
	motion.y -= JUMP_SPEED * 0.6  # multiplying just so it won't jump so high 
	lives -= damage
	if lives <= 0:
		end_game()
		
	
func manage_restart():
	if Input.is_action_just_pressed("Restart"):
		get_tree().reload_current_scene() 