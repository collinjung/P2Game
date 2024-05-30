extends RigidBody2D

@export var reset_state = false
@export var newPos = Vector2(0, 0)
@export var boulder_solved = false

func _integrate_forces(state):
	if reset_state:
		var t = state.get_transform()
		t.origin.x = newPos.x
		t.origin.y = newPos.y
		state.set_transform(t)
