extends Node2D

const enemyScene = preload("res://Scenes/Enemy.tscn")

export var damage = 1
export var life = 1
export (Texture) var texture

var current_texture

onready var enemy0 = load("res://Sprites/inimigo1.png")
onready var enemy1 = load("res://Sprites/square_blue.png")
onready var enemy2 = load("res://Sprites/square_orange.png")
onready var enemy3 = load("res://Sprites/square_red.png")

signal update_hud


func _ready():
	
	$Timer.wait_time = GLOBAL.ENEMY_DELAY
	$Timer.start()
	spawn()
	
func _process(delta):
	enemy_level_up()
	
func spawn():
	var enemy = enemyScene.instance()
	enemy.position = global_position
	enemy.get_node("Sprite").set_texture(texture)
	enemy.damage = GLOBAL.ENEMY_DAMAGE
	enemy.lives = GLOBAL.ENEMY_MAX_LIFE
	enemy.shoot_delay = GLOBAL.ENEMY_SHOOT_DELAY
	pick_current_sprite()
	get_parent().call_deferred("add_child", enemy)
	

func _on_Timer_timeout():
	$Timer.wait_time = GLOBAL.ENEMY_DELAY
	$Timer.start()
	spawn()
	
func enemy_level_up():
	if name == "EnemySpawner":
		if GLOBAL.ENEMY_MONEY >= GLOBAL.ENEMY_LEVEL_COST:
			if GLOBAL.ENEMY_LEVEL < GLOBAL.ENEMY_MAX_LEVEL:
				GLOBAL.ENEMY_MONEY -= GLOBAL.ENEMY_LEVEL_COST
				GLOBAL.ENEMY_LEVEL += 1
				GLOBAL.ENEMY_DAMAGE += 1
				GLOBAL.ENEMY_MAX_LIFE += 1
				GLOBAL.ENEMY_DELAY -= 2
				GLOBAL.ENEMY_LEVEL_COST += 6
				GLOBAL.ENEMY_SHOOT_DELAY -= 0.5
				emit_signal("update_hud")
#				print("enemy level up called")
#				print("enemy level is ", GLOBAL.ENEMY_LEVEL)
#				print("enemy damage = ", GLOBAL.ENEMY_DAMAGE)
#				print("enemy money = ", GLOBAL.ENEMY_MONEY)

func pick_current_sprite():
	if GLOBAL.PLAYER_LEVEL == 0:
		current_texture = enemy0
	if GLOBAL.PLAYER_LEVEL == 1:
		current_texture = enemy1
	if GLOBAL.PLAYER_LEVEL == 2:
		current_texture = enemy2
	if GLOBAL.PLAYER_LEVEL == 3:
		current_texture = enemy3

	
func change_sprite():
	get_parent().get_node("Sprite").set_texture(current_texture)
#	print(" ENMY SP: tried to change enemy sprite")