extends Node
@onready var warning = get_parent().get_node("Room7/Warning")
@onready var key_warning = get_parent().get_node("Room7/Key_Warning")
@onready var key_picked_up = false


func _ready():
	key_warning.visible = false
	
	
func _process(delta):
	if GameState.steel_mined < 10:
		warning.visible = true
	else:
		warning.visible = false
	
func _input(event):
	pass	
	

func _on_key_2_body_entered(body):
	if body.is_in_group("Player"):
		key_picked_up = true


func _on_key_hole_body_entered(body):
	if body.is_in_group("Player") and key_picked_up == false:
		key_warning.visible = true


func _on_key_hole_body_exited(body):
	if body.is_in_group("Player"):
		key_warning.visible = false
