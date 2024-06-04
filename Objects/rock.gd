extends StaticBody2D

@onready var mine_key_pressed = false
@onready var player_nearby = false
@onready var rockMinedSound = $AudioStreamPlayer2D_RockMined
@onready var rocksCompletedSound = get_parent().get_node("AudioStreamPlayer2D_RocksCompleted")

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_E and player_nearby:
			rockMinedSound.play()
			await get_tree().create_timer(0.4).timeout
			queue_free()
			var label = get_parent().get_parent().get_node("CanvasLayer").get_node("stone").get_node("Label").text
			var index = 1
			if label[1] != '/':
				index = 2
			var cur_mined = label.substr(0, index)
			var new_mined = int(cur_mined) + 1
			get_parent().get_parent().get_node("CanvasLayer").get_node("stone").get_node("Label").text = str(new_mined) + "/15"
			if new_mined == 15:
				rocksCompletedSound.play()
			GameState.stones_mined += 1
			
func _on_rock_area_2d_2_body_entered(body):
	if body.is_in_group("Player"):
		player_nearby = true

func _on_rock_area_2_body_exited(body):
	if body.is_in_group("Player"):
		player_nearby = false

