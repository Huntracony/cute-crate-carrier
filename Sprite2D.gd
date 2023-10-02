extends Sprite2D
var basePosition = position.y

# Called when the node enters the scene tree for the first time.
func _ready():
	set_flip_h(true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y = basePosition + get_parent().position_height
	pass