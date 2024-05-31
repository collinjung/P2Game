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
	var video_scene = preload("res://Cut Scenes/cut_scene.tscn")
	var video_instance = video_scene.instantiate()
	get_tree().current_scene.queue_free()
	get_tree().root.add_child(video_instance)
	get_tree().current_scene = video_instance

func _on_quit_pressed():
	get_tree().quit()
