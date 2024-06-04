extends Node2D
@onready var WaterDripSound = $AudioStreamPlayer2D_WaterDrip

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("CanvasLayer/stone/Label").text = str(GameState.stones_mined) + "/15"
	WaterDripSound.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_key_hole_body_entered(body):
	pass # Replace with function body.
