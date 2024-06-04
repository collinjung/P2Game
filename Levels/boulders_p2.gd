extends Node

@onready var level_completed_audio = $AudioStreamPlayer_Completion
@onready var one_boulder_done_audio = $AudioStreamPlayer2D_OneBoulderDone
@export var green_boulder_pos = Vector2(0, 0)
@export var red_boulder_pos = Vector2(0, 0)
@onready var green_boulder = $boulder_green
@onready var red_boulder = $boulder_red

var green_solved = false
var red_solved = false

func _on_green_goal_body_entered(body):
	if body.name == "boulder_green":
		green_solved = true
		green_boulder.boulder_solved = true
		var newPos = Vector2(126, -128)
		green_boulder.global_position = newPos
		green_boulder.newPos = newPos
		green_boulder.reset_state = true
		green_boulder.freeze = true
		one_boulder_done_audio.play()
	if green_solved and red_solved:
		await get_tree().create_timer(1.0).timeout
		get_tree().paused = true
		level_completed_audio.play()
		$NextLevel.position.x = -15
		await get_tree().create_timer(2.0).timeout
		get_tree().paused = false
		
func _on_red_goal_body_entered(body):
	if body.name == "boulder_red":
		red_solved = true
		red_boulder.boulder_solved = true
		var newPos = Vector2(126, 128)
		red_boulder.global_position = newPos
		red_boulder.newPos = newPos
		red_boulder.reset_state = true
		red_boulder.freeze = true
		one_boulder_done_audio.play()
	if green_solved and red_solved:
		await get_tree().create_timer(1.0).timeout
		get_tree().paused = true
		level_completed_audio.play()
		$NextLevel.position.x = -15
		await get_tree().create_timer(2.0).timeout
		get_tree().paused = false



