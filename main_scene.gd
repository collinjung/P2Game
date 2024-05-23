extends Node2D

@onready var hud : Control = $HUD
@onready var menu : Control = $Menu
@onready var main : Node2D = $Main
@onready var camera : Camera2D = $Main/Camera2D

var level_instance : Node2D

func _ready():
	Global.main_scene = self
	
func unload_level():
	if (is_instance_valid(level_instance)):
		level_instance.queue_free()

	level_instance = null


func load_level(level_name : String):
	unload_level()
	#var level_path := "res://Levels/level_1.tscn"
	var level_path := "res://Levels/%s.tscn" % level_name
	var level_resource := load(level_path)
	if (level_resource):
		level_instance = level_resource.instantiate()
		main.add_child(level_instance)
	get_tree().change_scene_to_file(level_path)
		
		
func _on_Load_1_pressed():
	load_level("level_1")

		
