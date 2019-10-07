extends Node2D

#export (Texture) var player0
#export (Texture) var player1
#export (Texture) var player2
#export (Texture) var player3

onready var player0 = load("res://Sprites/mendigo1.png")
onready var player1 = load("res://Sprites/square_blue.png")
onready var player2 = load("res://Sprites/square_orange.png")
onready var player3 = load("res://Sprites/square_red.png")

var current_texture = player0

func _ready():
	pick_current_sprite()
	change_sprite()

func pick_current_sprite():
	if GLOBAL.PLAYER_LEVEL == 0:
		current_texture = player0
	if GLOBAL.PLAYER_LEVEL == 1:
		current_texture = player1
		print("current sprite is 1")
	if GLOBAL.PLAYER_LEVEL == 2:
		current_texture = player2
	if GLOBAL.PLAYER_LEVEL == 3:
		current_texture = player3

	
func change_sprite():
	get_parent().get_node("Sprite").set_texture(current_texture)
#	print("Play Mng: tried to change sprite")