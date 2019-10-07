extends Node2D

var can_buy_upg = false
var can_buy_life = false

signal player_level_up

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
		buy_upg()
		
	if can_buy_life && Input.is_action_just_pressed("beg"):
		if GLOBAL.PLAYER_LIFE < GLOBAL.MAX_LIFE:
			GLOBAL.PLAYER_MONEY -= GLOBAL.LIFE_COST
			GLOBAL.PLAYER_LIFE += 1	
			print("life bought")
			print("player n of lifes = ", GLOBAL.PLAYER_LIFE)
			
func buy_upg():
	if GLOBAL.PLAYER_MONEY >= GLOBAL.LEVEL_COST && GLOBAL.PLAYER_LEVEL < GLOBAL.MAX_LEVEL:
		GLOBAL.PLAYER_MONEY -= GLOBAL.LEVEL_COST
		GLOBAL.PLAYER_LEVEL += 1
		GLOBAL.MAX_LIFE += 2
		GLOBAL.PLAYER_LIFE = GLOBAL.MAX_LIFE
		GLOBAL.PLAYER_DAMAGE += 1
		emit_signal("player_level_up")
		print("SHOP: player level up")
		print("SHOP: player level is", GLOBAL.PLAYER_LEVEL)
		
