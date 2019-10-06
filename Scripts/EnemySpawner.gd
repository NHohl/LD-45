extends Node2D

const enemyScene = preload("res://Scenes/Enemy.tscn")

export var damage = 1
export var life = 1
export (Texture) var texture

func _ready():
	spawn()
	$Timer.wait_time = GLOBAL.ENEMY_DELAY
	$Timer.start()
	
func spawn():
	var enemy = enemyScene.instance()
	enemy.position = global_position
	enemy.get_node("Sprite").set_texture(texture)
	get_parent().call_deferred("add_child", enemy)
	

func _on_Timer_timeout():
	spawn()
	

