extends CharacterBody2D

@export var move_speed: float = 100
@export var starting_direction: Vector2 = Vector2(0, -1)
@export var direction: Vector2 = Vector2(0, -1)
@export var lastRoom: Vector2 = Vector2(0, 0)
@export var lastPosition: Vector2 = Vector2(50, 144)
@export var magicInput: Array = []
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var camera = get_parent().get_node("Camera2D")
@onready var size: Vector2i = get_viewport_rect().size
@onready var player = get_parent().get_node("Player")
@onready var key = get_parent().get_node("Key2")
@onready var door = get_parent().get_node("LockedDoor")
@onready var playerWalkingSound = $AudioStreamPlayer_Walking
@onready var playerPushingSound = $AudioStreamPlayer_Pushing
@onready var keyPickedUpSound = $AudioStreamPlayer_Key
@onready var doorUnlockedSound = $AudioStreamPlayer_DoorUnlock
@onready var rockMinedSound = $AudioStreamPlayer_MineRock
@onready var animation = $AnimationPlayer
@onready var player_direction = Vector2.RIGHT


var push_force = 10
var key_picked_up = false
const FILE_BEGIN = "res://Levels/puzzle_"
const FILE_BEGIN_LEVEL = "res://Levels/level_"
var trigger = false

func _ready():
	update_animation_parameters(starting_direction)

func _input(event):
	if Input.is_action_just_pressed("mine"):
		if player_direction == Vector2.RIGHT:
			animation.play("mining_right")
		else:
			animation.play("mining_left")
	return event

func _process(_delta):
	if Input.is_action_just_pressed('spell'):
		print("fireball") 
	if Input.is_action_just_pressed("right"):
		player_direction = Vector2.RIGHT
	if Input.is_action_just_pressed("left"):
		player_direction = Vector2.LEFT
	#if Input.is_action_just_pressed('reset') and camera and player:
		#camera.position = lastRoom
		#player.position = lastPosition
	#if Input.is_action_just_pressed("mine"):
	
	

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
		if !playerPushingSound.playing and ("boulder" in b.name):
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

func _on_final_body_entered(body):
	if body.is_in_group("Player"):
		var current_scene_file = get_tree().current_scene.scene_file_path
		var level_num = current_scene_file.to_int()
		var current_puzzle_path = FILE_BEGIN + str(level_num) + ".tscn"
		get_tree().change_scene_to_file(current_puzzle_path)
		
		##Called to change to new Sceen
		#var TheRoot = get_node("/root")  #need this as get_node will stop work once you remove your self from the Tree
		#var ThisScene = get_node("/root/Node2D")
		#GameState.PreviousScreen = ThisScene  #variable in Autoload script
		#TheRoot.remove_child(ThisScene)
		#var current_scene_file = get_tree().current_scene.scene_file_path
		#var level_num = current_scene_file.to_int()
		#var current_puzzle_path = FILE_BEGIN + str(level_num) + ".tscn"
		#var NextScene = load(current_puzzle_path)
		#NextScene = NextScene.instantiate()
		#TheRoot.add_child(NextScene)


func _on_door_right_body_entered(body):
	if body.is_in_group("Player"):
		camera.position.x += 445
		player.position.x += 50
		lastRoom = camera.position
		lastPosition = camera.position + Vector2(60, 144)
		


func _on_door_left_body_entered(body):
	if body.is_in_group("Player"):
		camera.position.x -= 445
		player.position.x -= 50
		lastRoom = camera.position
		lastPosition = camera.position + Vector2(350, 144)


func _on_door_down_body_entered(body):
	if body.is_in_group("Player"):
		camera.position.y += 288
		player.position.y += 80
		lastRoom = camera.position
		lastPosition = camera.position + Vector2(224, 60)

func _on_door_up_body_entered(body):
	if body.is_in_group("Player"):
		camera.position.y -= 288
		player.position.y -= 80
		lastRoom = camera.position
		lastPosition = camera.position + Vector2(224, 350)


func _on_key_2_body_entered(body):
	if body.is_in_group("Player") and key_picked_up == false:
		keyPickedUpSound.play()
		key.visible = false
		$key_found.visible = true
		key_picked_up = true

func _on_key_hole_body_entered(body):
	if body.is_in_group("Player") and key_picked_up == true:
		door.position.x += 500
		doorUnlockedSound.play()
		get_tree().paused = true
		$key_found.visible = false
		await get_tree().create_timer(0.5).timeout
		get_tree().paused = false
		
		


func _on_return_from_puzzle_body_entered(body):
	if body.is_in_group("Player"):
		var current_scene_file = get_tree().current_scene.scene_file_path
		var next_level_number = current_scene_file.to_int()
		var next_level_path = FILE_BEGIN_LEVEL + str(next_level_number) + ".tscn"
		trigger = true
		get_tree().change_scene_to_file(next_level_path)
		#var TheRoot = get_node("/root")  #need this as get_node will stop work once you remove your self from the Tree
		#var ThisScene = get_node("/root/Node2D")
#
		#TheRoot.remove_child(ThisScene)
		#ThisScene.call_deferred("free")
		#
		#var NextScene = GameState.PreviousScreen
		#TheRoot.add_child(NextScene)
		
		
