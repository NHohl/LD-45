extends Node2D

var can_buy_upg = false
var can_buy_life = false

signal player_level_up

func _ready():
	$Upgrade/LevelCost.set_text(str(GLOBAL.LEVEL_COST))
	$Life/LifeCost.set_text(str(GLOBAL.LIFE_COST))


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
			SoundManager.get_node("Buy").play()
			print("life bought")
			print("player n of lifes = ", GLOBAL.PLAYER_LIFE)
			
func buy_upg():
	if GLOBAL.PLAYER_MONEY >= GLOBAL.LEVEL_COST && GLOBAL.PLAYER_LEVEL < GLOBAL.MAX_LEVEL:
		GLOBAL.PLAYER_MONEY -= GLOBAL.LEVEL_COST
		GLOBAL.PLAYER_LEVEL += 1
		GLOBAL.LEVEL_COST += 5
		GLOBAL.LIFE_COST += 1
		GLOBAL.MAX_LIFE += 2
		GLOBAL.PLAYER_LIFE = GLOBAL.MAX_LIFE
		GLOBAL.PLAYER_DAMAGE += 1
		emit_signal("player_level_up")
		SoundManager.get_node("Buy").play()
		$Upgrade/LevelCost.set_text(str(GLOBAL.LEVEL_COST))
		$Life/LifeCost.set_text(str(GLOBAL.LIFE_COST))
		
		print("SHOP: player level up")
		print("SHOP: player level is ", GLOBAL.PLAYER_LEVEL)
		
