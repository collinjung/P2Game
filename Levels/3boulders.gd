extends Node

@export var green_solved = false
@export var red_solved = false
@export var purple_solved = false
@onready var level_completed_audio = $AudioStreamPlayer_Completion
@onready var one_boulder_done_audio = $AudioStreamPlayer2D_OneBoulderDone
@onready var green_boulder = get_parent().get_node("three_boulders").get_node("boulder_green")
@onready var red_boulder = get_parent().get_node("three_boulders").get_node("boulder_red")
@onready var purple_boulder = get_parent().get_node("three_boulders").get_node("boulder_purple")

func _process(_delta):
	if Input.is_action_just_pressed('level_reset'):
		print("hihihi")
		
func _on_green_goal_body_entered(body):
	if body.name == "boulder_green":
		green_solved = true
		green_boulder.boulder_solved = true
		var newPos = Vector2(128, -30)
		one_boulder_done_audio.play()
		if purple_solved == true:
			green_boulder.global_position = newPos
			green_boulder.newPos = newPos
			green_boulder.reset_state = true
			green_boulder.freeze = true
	if green_solved and red_solved and purple_solved:
		await get_tree().create_timer(1.0).timeout
		get_tree().paused = true
		level_completed_audio.play()
		$NextLevel.position.x = 0
		await get_tree().create_timer(2.0).timeout
		get_tree().paused = false

func _on_red_goal_body_entered(body):
	if body.name == "boulder_red":
		red_solved = true
		red_boulder.boulder_solved = true
		var newPos = Vector2(176, -78)
		red_boulder.global_position = newPos
		red_boulder.newPos = newPos
		red_boulder.reset_state = true
		red_boulder.freeze = true
		one_boulder_done_audio.play()
	if green_solved and red_solved and purple_solved:
		await get_tree().create_timer(1.0).timeout
		get_tree().paused = true
		level_completed_audio.play()
		$NextLevel.position.x = 0
		await get_tree().create_timer(2.0).timeout
		get_tree().paused = false

func _on_purple_goal_body_entered(body):
	if body.name == "boulder_purple":
		purple_solved = true
		purple_boulder.boulder_solved = true
		var newPos = Vector2(176, 50)
		purple_boulder.global_position = newPos
		purple_boulder.newPos = newPos
		purple_boulder.reset_state = true
		purple_boulder.freeze = true
		one_boulder_done_audio.play()
	if green_solved and red_solved and purple_solved:
		await get_tree().create_timer(1.0).timeout
		get_tree().paused = true
		level_completed_audio.play()
		$NextLevel.position.x = 0
		await get_tree().create_timer(2.0).timeout
		get_tree().paused = false
