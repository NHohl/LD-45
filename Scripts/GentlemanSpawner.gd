extends Node2D


const gentlemanScene = preload("res://Scenes/Gentleman.tscn")


func _ready():
	$Timer.wait_time = 3
	$Timer.start()
	
func spawn():
	var gentleman = gentlemanScene.instance()
	gentleman.position = global_position
	get_parent().call_deferred("add_child", gentleman)
	

func _on_Timer_timeout():
	spawn()
