extends Area2D

export var money_content = 1
export var money_increase = 1
export var money_delay = 2

func _ready():
	$Timer.wait_time = money_delay

func _process(delta):
	$MoneyContentLabel.set_text(str(money_content))


func _on_Gentleman_body_entered(body):
	if "Player" in body.name:
		GLOBAL.PLAYER_MONEY += money_content
		money_content = 0
	elif "Enemy" in body.name:
		GLOBAL.ENEMY_MONEY += money_content
#		print("enemy money is",GLOBAL.ENEMY_MONEY)
		money_content = 0
#	print("Player money = ", GLOBAL.PLAYER_MONEY)
#	print("Enemy money = ", GLOBAL.ENEMY_MONEY)

func _on_Timer_timeout():
	money_content += money_increase
#	print("money_content =", money_content)