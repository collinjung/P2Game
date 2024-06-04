extends RigidBody2D

#var original_position: Vector2
@onready var reset_pressed = false
var original_position: Vector2

func _ready():
	original_position = global_position

func _integrate_forces(state):
	if reset_pressed:
		reset_pressed = false
		state.linear_velocity = Vector2.ZERO
		state.angular_velocity = 0
		state.transform.origin = original_position
		$CollisionShape2D.disabled = true
		
		
func _process(delta):
	if Input.is_action_just_pressed("reset"):
		reset_pressed = true

