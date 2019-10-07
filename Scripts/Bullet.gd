extends Area2D

const SPEED = 140
var velocity = Vector2()
var direction = 1
var damage
var current_texture


func _ready():
#	if GLOBAL.PLAYER_LEVEL > 0:
	pick_sprite()

func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)
	
func set_bullet_direction(dir):
	direction = dir

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func pick_sprite():
	if GLOBAL.PLAYER_LEVEL == 1:
		current_texture = load("res://Sprites/PlayerBullets/pbala1.png")
		$Sprite.set_texture(current_texture)
	if GLOBAL.PLAYER_LEVEL == 2:
		current_texture = load("res://Sprites/PlayerBullets/pbala2.png")
		$Sprite.set_texture(current_texture)
	if GLOBAL.PLAYER_LEVEL == 3:
		current_texture = load("res://Sprites/PlayerBullets/pbala3.png")
		$Sprite.set_texture(current_texture)
#	else:
#		print("bullet: player is level 0")
#		return
		


func _on_Bullet_body_entered(body):
	if "Enemy" in body.name:
		body.hurt(damage)
	if body.name != "Player":
		queue_free()
