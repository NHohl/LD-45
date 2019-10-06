extends Area2D

export var money_content = 1
export var money_increase = 1
export var money_delay = 2

func _ready():
	$Timer.wait_time = money_delay

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Gentleman_body_entered(body):
	if "Player" in body.name:
		GLOBAL.PLAYER_MONEY += money_content
	elif "Enemy" in body.name:
		GLOBAL.ENEMY_MONEY += money_content
#	print("Player money = ", GLOBAL.PLAYER_MONEY)
#	print("Enemy money = ", GLOBAL.ENEMY_MONEY)
	call_deferred("queue_free")

func _on_Timer_timeout():
	money_content += money_increase
#	print("money_content =", money_content)