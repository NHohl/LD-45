extends KinematicBody2D

const UP = Vector2(0, -1) #the constant that will make the normal value for move_and_slide
const MOVE_SPEED = 200
export var JUMP_HEIGHT = -600

var GRAVITY = 20
var jumped = false
var motion = Vector2()
var able_to_shoot = true
var juninho = 0
var direction = 0
var must_not_shoot = false


export (PackedScene) var bullet
signal shoot
signal HP1_damage


	
	
func _physics_process(delta):
	handle_movement()
	motion.y += GRAVITY        #motion downwards for gravity, keeps increasing if does not hit floor
	motion = move_and_slide(motion, UP) #move and slide returns what motion is left
	                                    #when hits ground, motion = 0
	check_juninho()

	if jumped == true:     #for some reason this part doesn't work inside handle_movement
		if motion.y > 0:
			GRAVITY = 50
		if is_on_floor():
			jumped = false
			GRAVITY = 20	
			
	if able_to_shoot == true and must_not_shoot == false:
		if Input.is_action_pressed("C") or Input.is_action_pressed("ui_accept") or Input.is_action_pressed("X"):
			shoot()

func handle_movement():
	if Input.is_action_pressed("D"):
		motion.x = MOVE_SPEED
		direction = 0
		if $Sprite.is_flipped_h() == true:
			$Sprite.set_flip_h(false)
	
	elif Input.is_action_pressed("A"):
		motion.x = -MOVE_SPEED
		direction = 3.15
		if $Sprite.is_flipped_h() == false:
			$Sprite.set_flip_h(true)

	else:
		motion.x = 0
		
	if is_on_floor():   #only works when with move_and_slide executes, needs a normal value to find floor
		if Input.is_action_just_pressed("W"):	
			motion.y = JUMP_HEIGHT
			jumped = true



func shoot():
		$Momozudo.play()
		emit_signal("shoot", bullet, $Muzzle.global_position, direction)
		print("signal emited")
		able_to_shoot = false
		print("cant shoot")
		$BulletTimer.start()
		
	
func _on_BulletTimer_timeout():
	able_to_shoot = true
	
func take_juninho():
	juninho += 1
	print("player 1 juninho is ",  juninho)
	emit_signal("HP1_damage")

func check_juninho():
	if juninho == 5:
		juninho = 0
		$Sprite.set_flip_h(false)
		direction = 0