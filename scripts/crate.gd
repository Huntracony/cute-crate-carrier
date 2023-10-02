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
signal crateHeld(heldFrom, draggedTo, intensity)
signal crateReleased()

func _physics_process(_delta):
	if not grabbed: return
	var globalGrabPos = to_global(grabPos)
	var toMouseVector = get_global_mouse_position() - globalGrabPos
	var toMouseDistance = toMouseVector.length()
	if toMouseDistance > MAX_DISTANCE:
		toMouseVector = toMouseVector.normalized() * MAX_DISTANCE
	var force = toMouseVector * FORCE_FACTOR
	var offset = globalGrabPos - global_position
#	print(force)
	apply_force(force, offset)
	
	var globalOffset = global_position + offset
	crateHeld.emit(globalOffset, globalOffset + toMouseVector,
			toMouseVector.length()/MAX_DISTANCE)

# Mouse up anywhere
func _input(event):
	if not grabbed: return
	if not event is InputEventMouseButton: return
	if event.pressed or event.button_index != 1: return
	grabbed = false
	gravity_scale = NORMAL_GRAVITY
	crateReleased.emit()

# Mouse down in hitbox
func _on_input_event(_viewport, event, _shape_idx):
	if not event is InputEventMouseButton: return
	if not event.pressed or event.button_index != 1: return
	grabbed = true
	gravity_scale = GRABBED_GRAVITY
	grabPos = get_local_mouse_position()

func removeSelf():
#	get_parent().remove_child(self)
	queue_free()
