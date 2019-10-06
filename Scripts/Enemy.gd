extends KinematicBody2D

const GRAVITY = 1000
const SPEED = 50
const FLOOR = Vector2(0, -1)

var velocity = Vector2()

var direction = 1 #here 1 represents right for convenience

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
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