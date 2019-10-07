extends Area2D

const SPEED = 140
var velocity = Vector2()
var direction = 1
var damage
var current_texture

func _ready():
	pick_sprite()

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
#		print("enemy bul: damage = ", damage)
	if !"Enemy" in body.name:
		queue_free()



func pick_sprite():
	if GLOBAL.ENEMY_LEVEL == 0:
		current_texture = load("res://Sprites/EnemyBullets/ebala0.png")
		$Sprite.set_texture(current_texture)
	if GLOBAL.ENEMY_LEVEL == 1:
		current_texture = load("res://Sprites/EnemyBullets/ebala1.png")
		$Sprite.set_texture(current_texture)
	if GLOBAL.ENEMY_LEVEL == 2:
		current_texture = load("res://Sprites/EnemyBullets/ebala2.png")
		$Sprite.set_texture(current_texture)
	if GLOBAL.ENEMY_LEVEL == 3:
		current_texture = load("res://Sprites/EnemyBullets/ebala3.png")
		$Sprite.set_texture(current_texture)