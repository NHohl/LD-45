extends Node2D

const enemyScene = preload("res://Scenes/Enemy.tscn")

func _ready():
	spawn()
	
func spawn():
	var enemy = enemyScene.instance()
	get_parent().call_deferred("add_child", enemy)
	