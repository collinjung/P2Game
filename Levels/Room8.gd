extends Node
@onready var warning = get_parent().get_node("Room8/Warning")


func _process(delta):
	if GameState.stones_mined < 15:
		warning.visible = true
	else:
		warning.visible = false
	
func _input(event):
	pass	
	
	
