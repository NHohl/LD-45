extends Node

export (Texture) var player0
export (Texture) var player1
export (Texture) var player2
export (Texture) var player3

var current_texture = player0

func _ready():
	pass

func pick_current_sprite():
	if GLOBAL.PLAYER_LEVEL == 1:
		pass
	
func change_sprite():
	get_parent().Sprite.set_texture()