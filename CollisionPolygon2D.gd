extends CollisionPolygon2D
var basePosition = position.y

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y = basePosition + get_parent().position_height
	pass
