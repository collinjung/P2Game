extends Node2D

@export var green_boulder_pos = Vector2(0, 0)
@export var red_boulder_pos = Vector2(0, 0)
@export var purple_boulder_pos = Vector2(0, 0)
@onready var green_boulder = $three_boulders.get_node("boulder_green")
@onready var red_boulder = $three_boulders.get_node("boulder_red")
@onready var purple_boulder = $three_boulders.get_node("boulder_purple")
@onready var player = $PlayerCat

var green_solved = false
var red_solved = false
var purple_solved = false
var player_pos = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	if Input.is_action_just_pressed('reset'):
		get_tree().reload_current_scene()
	#if Input.is_action_just_pressed('checkpoint'):
		#green_boulder_pos = green_boulder.position
		#red_boulder_pos =  red_boulder.position
		#purple_boulder_pos =  purple_boulder.position
		#green_solved = green_boulder.boulder_solved
		#red_solved = red_boulder.boulder_solved
		#purple_solved = purple_boulder.boulder_solved
		#player_pos = player.position
	#if Input.is_action_just_pressed('load_checkpoint'):
		#player.position = player_pos
		#green_boulder.global_position = green_boulder_pos
		#green_boulder.newPos = green_boulder_pos
		#green_boulder.reset_state = true
		#red_boulder.global_position = red_boulder_pos
		#red_boulder.newPos = red_boulder_pos
		#red_boulder.reset_state = true
		#purple_boulder.global_position = purple_boulder_pos
		#purple_boulder.newPos = purple_boulder_pos
		#purple_boulder.reset_state = true
		#green_boulder.boulder_solved = green_solved
		#red_boulder.boulder_solved = red_solved
		#purple_boulder.boulder_solved = purple_solved
		#green_boulder.freeze = false
		#red_boulder.freeze = false
		#purple_boulder.freeze = false
		#green_boulder.reset_state = false
		#red_boulder.reset_state = false
		#purple_boulder.reset_state = false
		
		
