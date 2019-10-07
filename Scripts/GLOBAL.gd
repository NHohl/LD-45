extends Node


export var PLAYER_MONEY = 0
export var PLAYER_LIFE = 2
export var MAX_LIFE = 2
export var LIFE_COST = 1

export var PLAYER_LEVEL = 0
export var LEVEL_COST = 1 
export var MAX_LEVEL = 3

export var PLAYER_DAMAGE = 0

var ENEMY_MONEY = 0
export var ENEMY_DELAY = 10 #default is 10
export var ENEMY_DAMAGE = 1
export var ENEMY_MAX_LIFE = 1
export var ENEMY_LEVEL = 0
export var ENEMY_MAX_LEVEL = 3
export var ENEMY_LEVEL_COST = 3 #default is 3
export var ENEMY_SHOOT_DELAY = 3

#func _ready():
#	connect("player_level_up", get_node("../Player"), "_on_GLOBAL_player_level_up")
##	emit_signal("player_level_up")
	
func _process(delta):
	pass
	



#func buy_upg():
#	if PLAYER_MONEY >= LEVEL_COST && PLAYER_LEVEL < MAX_LEVEL:
#		PLAYER_MONEY -= LEVEL_COST
#		PLAYER_LEVEL += 1
#		emit_signal("player_level_up")
#		print("player lvl up enviado")
		