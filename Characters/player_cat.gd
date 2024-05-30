extends CharacterBody2D

@export var move_speed: float = 100
@export var starting_direction: Vector2 = Vector2(0, -1)
@export var direction: Vector2 = Vector2(0, -1)
@export var lastRoom: Vector2 = Vector2(0, 0)
@export var lastPosition: Vector2 = Vector2(224, 144)
@export var magicInput: Array = []
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var camera = get_parent().get_node("Camera2D")
@onready var size: Vector2i = get_viewport_rect().size
@onready var player = get_parent().get_node("Player")
@onready var playerWalkingSound = $AudioStreamPlayer_Walking
@onready var playerPushingSound = $AudioStreamPlayer_Pushing

var push_force = 10
const FILE_BEGIN = "res://Levels/puzzle_"

func _ready():
	update_animation_parameters(starting_direction)

func _input(ev):
	return ev

func _process(delta):
	if Input.is_action_just_pressed('spell'):
		print("fireball") 
	if Input.is_action_just_pressed('reset'):
		
		camera.position = lastRoom
		player.position = lastPosition
	if Input.is_action_just_pressed('level_reset'):
		get_tree().reload_current_scene()

func _physics_process(_delta):
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	update_animation_parameters(input_direction)
	direction = input_direction
	velocity = input_direction * move_speed
	move_and_slide()
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		var b = c.get_collider()
		if !playerPushingSound.playing and (b.name == "boulder_green" or b.name == "boulder_red" or b.name == "boulder_purple"):
			playerPushingSound.play()	
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
	pick_new_state()



func update_animation_parameters(move_input: Vector2):
	if move_input != Vector2.ZERO:
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)

func pick_new_state():
	if velocity != Vector2.ZERO:
		state_machine.travel("Walk")
		if !playerWalkingSound.playing:
			playerWalkingSound.play()
	else:
		state_machine.travel("Idle")
		playerWalkingSound.stop()

#func _on_body_entered(body):
	#if body.is_in_group("Player"):
		#camera.position.x += direction.x * 444
		#camera.position.y += direction.y * 292
		#player.position.x += direction.x * 15
		#player.position.y += direction.y * 15
		#lastRoom = camera.position
		#lastPosition = camera.position + Vector2(224, 144)

func _on_final_body_entered(body):
	if body.is_in_group("Player"):
		var current_scene_file = get_tree().current_scene.scene_file_path
		var level_num = current_scene_file.to_int()
		var current_puzzle_path = FILE_BEGIN + str(level_num) + ".tscn"
		get_tree().change_scene_to_file(current_puzzle_path)


func _on_door_right_body_entered(body):
	if body.is_in_group("Player"):
		camera.position.x += 445
		player.position.x += 50
		lastRoom = camera.position
		lastPosition = camera.position + Vector2(224, 144)
		


func _on_door_left_body_entered(body):
	if body.is_in_group("Player"):
		camera.position.x -= 445
		player.position.x -= 50
		lastRoom = camera.position
		lastPosition = camera.position + Vector2(224, 144)


func _on_door_down_body_entered(body):
	if body.is_in_group("Player"):
		camera.position.y += 288
		player.position.y += 80
		lastRoom = camera.position
		lastPosition = camera.position + Vector2(224, 144)

func _on_door_up_body_entered(body):
	if body.is_in_group("Player"):
		camera.position.y -= 288
		player.position.y -= 80
		lastRoom = camera.position
		lastPosition = camera.position + Vector2(224, 144)

func _on_boulder_green_body_entered(body):
	if body.is_in_group("Player"):
		print("Entered")
