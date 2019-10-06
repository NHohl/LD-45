extends Area2D

var velocity = Vector2()
var speed = 1000

func start_at(pos, dir):
	position = pos
	velocity = Vector2(speed, 0).rotated(dir)
	
func _physics_process(delta):
	position += velocity * delta
	
func _on_Visibility_exit_screen():
	queue_free()
	

func _on_Bullet1_body_shape_entered( body_id, body, body_shape, area_shape ):
		if body.is_in_group("Enemy"):
			#body.take_damage()
			queue_free()