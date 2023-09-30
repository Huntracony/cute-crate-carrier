extends RigidBody2D

const GRAVITY = 100
const FORCE_FACTOR = 15
var grabbed = false
var grabPos = Vector2()

func _ready():
	linear_damp = 1.0
	angular_damp = 0.1
	add_constant_force(Vector2(0, GRAVITY))

func _physics_process(_delta):
	if not grabbed: return
	var globalGrabPos = to_global(grabPos)
	var force = get_global_mouse_position() - globalGrabPos
	var offset = globalGrabPos - global_position
	apply_force(force * FORCE_FACTOR, offset)

func _input(event):
	if not event is InputEventMouseButton: return
	if event.pressed or event.button_index != 1: return
	grabbed = false

func _on_input_event(_viewport, event, _shape_idx):
	if not event is InputEventMouseButton: return
	if not event.pressed or event.button_index != 1: return
	print(event)
	grabbed = true
	grabPos = get_local_mouse_position()
