extends RigidBody2D

const GRAVITY = 100
var is_hovered = false
var grabbed = false
# Called when the node enters the scene tree for the first time.
func _ready():
	add_constant_force(Vector2(0, GRAVITY))
	pass # Replace with function body.


func _input(event):
	if event is InputEventMouseButton:
		if event.pressed && is_hovered:
			grabbed = true
		elif not event.pressed && grabbed:
			grabbed = false
	elif event is InputEventMouseMotion && grabbed:
		linear_velocity = event.velocity
#		position.x = event.loca
#		apply_impulse(event.velocity)
		
func _process(delta):
	pass


func _on_mouse_shape_entered(shape_idx):
	is_hovered = true


func _on_mouse_shape_exited(shape_idx):
	is_hovered = false
	
