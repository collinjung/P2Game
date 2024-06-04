extends Node2D

@onready var open_hint_sound = $AudioStreamPlayer2D_OpenHint
@onready var close_hint_sound = $AudioStreamPlayer2D_CloseHint
@onready var fire_sound = $AudioStreamPlayer2D_FireSound
# Called when the node enters the scene tree for the first time.
func _ready():
	fire_sound.play()

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_H:
			if get_node("CanvasLayer/hint").visible == false:
				open_hint_sound.play()
			else:
				close_hint_sound.play()
			get_node("CanvasLayer/hint").visible = not get_node("CanvasLayer/hint").visible



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed('reset'):
		get_tree().reload_current_scene()

		
		
