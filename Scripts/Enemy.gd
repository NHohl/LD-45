extends KinematicBody2D

const GRAVITY = 1000
const SPEED = 50
const JUMP_SPEED = 300
const FLOOR = Vector2(0, -1)

var velocity = Vector2()

var direction = 1 #here 1 represents right for convenience
var is_dead = false
var lives = 2

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
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
	
	
	
func hurt(damage):
	velocity = Vector2(0,0)
	velocity.y -= JUMP_SPEED * 0.6  # multiplying just so it won't jump so high 
	lives -= damage
	if lives <= 0:
		queue_free()
		
#TODO Fazer animação de morte e delay dos corpos antes de sumir (se der tempo)
# Vídeo 9 da série UmaiPixel
	
