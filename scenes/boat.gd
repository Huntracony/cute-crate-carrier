extends RigidBody2D
const MAX_BOB = 3
const BOB = false
var basePosition = 0
var time = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	if BOB:
		basePosition = position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if BOB:
		time += delta
		position.y = basePosition + sin(time) * MAX_BOB
