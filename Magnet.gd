extends RigidBody2D

var anchor = Vector2(20, 0)

func _ready():
	angular_damp = 0.2
	linear_damp = 1.5

func _process(delta):
	var force = get_global_mouse_position() - to_global(anchor)
	apply_force(force * 8, anchor)
	force = get_global_mouse_position() - to_global(-anchor)
	apply_force(force * 8, -anchor)
	pass
