extends Node

var green_solved = false
var red_solved = false
var purple_solved = false

func _on_green_goal_body_entered(body):
	if body.name == "boulder_green":
		green_solved = true
	if green_solved and red_solved and purple_solved:
		$NextLevel.position.x = 0

func _on_red_goal_body_entered(body):
	if body.name == "boulder_red":
		red_solved = true
	if green_solved and red_solved and purple_solved:
		$NextLevel.position.x = 0

func _on_purple_goal_body_entered(body):
	if body.name == "boulder_purple":
		purple_solved = true
	if green_solved and red_solved and purple_solved:
		$NextLevel.position.x = 0