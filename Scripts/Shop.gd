extends Node2D

var can_buy_upg = false
var can_buy_life = false

func _ready():
	pass


func _on_Upgrade_body_entered(body):
	if "Player" in body.name:
		can_buy_upg = true
		
func _on_Life_body_entered(body):
	if "Player" in body.name:
		can_buy_life = true

func _on_Upgrade_body_exited(body):
	if "Player" in body.name:
		can_buy_upg = false

func _on_Life_body_exited(body):
	if "Player" in body.name:
		can_buy_life = false



func _process(delta):
	if can_buy_upg && Input.is_action_just_pressed("beg"):
		GLOBAL.PLAYER_LEVEL += 1
		print("upg bought")
		
	if can_buy_life && Input.is_action_just_pressed("beg"):
		GLOBAL.PLAYER_LIFE += 1	
		print("life bought")
			
