extends Node2D

@onready var fire_sound = $AudioStreamPlayer2D_FireSound
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("CanvasLayer/stone/Label").text = str(GameState.stones_mined) + "/15"
	get_node("CanvasLayer/iron/Label").text = str(GameState.steel_mined) + "/10"
	fire_sound.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
