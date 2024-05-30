extends StaticBody2D

@onready var mine_key_pressed = false
@onready var player_nearby = false
@onready var rockMinedSound = $AudioStreamPlayer2D_RockMined

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_E and player_nearby:
			rockMinedSound.play()
			await get_tree().create_timer(0.4).timeout
			queue_free()
			var mined = int(get_parent().get_parent().get_node("CanvasLayer").get_node("Label").text) + 1
			get_parent().get_parent().get_node("CanvasLayer").get_node("Label").text = str(mined)
			
			
func _on_rock_area_2d_2_body_entered(body):
	if body.is_in_group("Player"):
		player_nearby = true

func _on_rock_area_2_body_exited(body):
	if body.is_in_group("Player"):
		player_nearby = false

