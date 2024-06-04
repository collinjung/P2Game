extends CharacterBody2D

const speed = 30

var direction = Vector2.RIGHT
var start_pos
var current_state = IDLE
var is_roaming = true
var is_chatting = false

var player
var player_in_chat_zone = false
@onready var message = get_parent().get_node("CanvasLayer").get_node("Label")

enum {
	IDLE,
}

func _ready():
	randomize()
	start_pos = position
	message.visible = false

	
func _process(delta):
	if player_in_chat_zone == true:
		if Input.is_action_just_pressed("chat"):
			message.visible = false
			start_dialog("whiskers_timeline")
			
	if current_state == 0 or current_state == 1:
		$AnimatedSprite2D.play("idle")
				
		

func _on_chat_detection_area_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		player_in_chat_zone = true
		message.visible = true


func _on_chat_detection_area_body_exited(body):
	if body.is_in_group("Player"):
		player = body
		player_in_chat_zone = false

func choose(array):
	array.shuffle()
	return array.front()
	
func _on_timer_timeout():
	$Timer.wait_time = choose([0.5, 1, 1.5])
	current_state = IDLE

func start_dialog(dialogue_string):
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start(dialogue_string)
	is_chatting = true
	is_roaming = false
	$AnimatedSprite2D.play("chatting")
	
func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	var video_scene = preload("res://Cut Scenes/final_scene.tscn")
	var video_instance = video_scene.instantiate()
	get_tree().current_scene.queue_free()
	get_tree().root.add_child(video_instance)
	get_tree().current_scene = video_instance

