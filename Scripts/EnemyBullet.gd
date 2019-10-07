extends Area2D

const SPEED = 140
var velocity = Vector2()
var direction = 1
var damage

func _ready():
	pass

func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)
	
func set_bullet_direction(dir):
	direction = dir

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Bullet_body_entered(body):
	if "Player" in body.name:
		body.hurt(damage)
	if !"Enemy" in body.name:
		queue_free()
