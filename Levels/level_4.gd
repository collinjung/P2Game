extends Node2D
@onready var ending_music = $AudioStreamPlayer2D_EndingMusic

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("CanvasLayer/stone/Label").text = str(GameState.stones_mined) + "/15"
	get_node("CanvasLayer/iron/Label").text = str(GameState.steel_mined) + "/10"
	get_node("CanvasLayer/diamond/Label").text = str(GameState.diamond_mined) + "/5"
	AudioPlayer._pause_music()
	ending_music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
