extends RigidBody2D

const FORCE_FACTOR = 15
const NORMAL_GRAVITY = 1.0
const GRABBED_GRAVITY = 0.5
const MAX_DISTANCE = 200
func _ready():
	linear_damp = 1.0
	angular_damp = 0.1
	gravity_scale = NORMAL_GRAVITY

var grabbed = false
var grabPos = Vector2()

func _physics_process(_delta):
	if not grabbed: return
	var globalGrabPos = to_global(grabPos)
	var force = get_global_mouse_position() - globalGrabPos
	var distance_length = force.length()
	if distance_length > MAX_DISTANCE:
		force = force.normalized() * MAX_DISTANCE
	var offset = globalGrabPos - global_position
#	print(force * FORCE_FACTOR)
	apply_force(force * FORCE_FACTOR, offset)

func _input(event):
	if not event is InputEventMouseButton: return
	if event.pressed or event.button_index != 1: return
	grabbed = false
	gravity_scale = NORMAL_GRAVITY

func _on_input_event(_viewport, event, _shape_idx):
	if not event is InputEventMouseButton: return
	if not event.pressed or event.button_index != 1: return
	print(event)
	grabbed = true
	gravity_scale = GRABBED_GRAVITY
	grabPos = get_local_mouse_position()
