extends StaticBody2D

@onready var mine_key_pressed = false
@onready var player_nearby = false
@onready var SteelMinedSound = $AudioStreamPlayer2D_SteelMined
@onready var steelCompletedSound = get_parent().get_node("AudioStreamPlayer2D_ResourceCompleted")

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_E and player_nearby:
			SteelMinedSound.play()
			await get_tree().create_timer(0.4).timeout
			queue_free()
			GameState.steel_mined += 1
			get_parent().get_parent().get_node("CanvasLayer").get_node("iron").get_node("Label").text = str(GameState.steel_mined) + "/10"
			if GameState.steel_mined == 10:
				steelCompletedSound.play()

			
func _on_rock_area_2d_2_body_entered(body):
	if body.is_in_group("Player"):
		player_nearby = true

func _on_rock_area_2_body_exited(body):
	if body.is_in_group("Player"):
		player_nearby = false

