extends CharacterBody2D

const speed = 30

@onready var message = get_parent().get_node("CanvasLayer").get_node("Label")
var direction = Vector2.RIGHT
var start_pos
var current_state = IDLE
var is_roaming = true
var is_chatting = false

var player
var player_in_chat_zone = false

var min_x = 48
var max_x = 160
var min_y = 95
var max_y = 150

enum {
	IDLE,
	NEW_DIR,
	MOVE,
}

func _ready():
	randomize()
	start_pos = position
	Dialogic.signal_event.connect(DialogicSignal)
	message.visible = false
	
func _process(delta):
	if player_in_chat_zone == true:
		if Input.is_action_just_pressed("chat"):
			message.visible = false
			start_dialog("squeak_timeline")

			
	if current_state == 0 or current_state == 1:
		$AnimatedSprite2D.play("idle")
	elif current_state == 2 and !is_chatting:
		if direction.x == -1:
			$AnimatedSprite2D.play("walk_left")
		if direction.x == 1:
			$AnimatedSprite2D.play("walk_right")
		if direction.y == -1:
			$AnimatedSprite2D.play("walk_up")
		if direction.y == 1:
			$AnimatedSprite2D.play("walk_down")
	
	if is_roaming:
		match current_state:
			IDLE:
				pass
			NEW_DIR:
				direction = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
			MOVE:
				move(delta)
				
				
func choose(array):
	array.shuffle()
	return array.front()
	
func move(delta):
	if !is_chatting:
		var new_position = position + direction * speed * delta
		
		# Check boundaries and adjust direction if necessary
		if new_position.x < min_x:
			direction = Vector2.RIGHT
		elif new_position.x > max_x:
			direction = Vector2.LEFT
		elif new_position.y < min_y:
			direction = Vector2.DOWN
		elif new_position.y > max_y:
			direction = Vector2.UP
		else:
			position = new_position
		

func _on_chat_detection_area_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		player_in_chat_zone = true
		message.visible = true


func _on_chat_detection_area_body_exited(body):
	if body.is_in_group("Player"):
		player = body
		player_in_chat_zone = false
		message.visible = false


func _on_timer_timeout():
	$Timer.wait_time = choose([0.5, 1, 1.5])
	current_state = choose([IDLE, NEW_DIR, MOVE])
	
func start_dialog(dialogue_string):
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start(dialogue_string)
	is_chatting = true
	is_roaming = false
	$AnimatedSprite2D.play("chatting")
	
func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	Global.encountered_squeaks = true
	
	
	
func DialogicSignal(arg: String):
	if arg == "exit_squeak":
		$Timer.stop()
		$Timer.wait_time = 1000
		direction = Vector2.LEFT
		current_state = MOVE
		is_chatting = false
		is_roaming = true
		await get_tree().create_timer(30.0).timeout
		self.queue_free()
