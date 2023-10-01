extends StaticBody2D
const CART_DISTANCE = 300
const BEGIN_POSITION = 1350
const HEIGHT = 477
var cartPositions = [Vector2(BEGIN_POSITION, HEIGHT), 
					Vector2(BEGIN_POSITION - CART_DISTANCE, HEIGHT), 
					Vector2(BEGIN_POSITION - CART_DISTANCE * 2, HEIGHT)]

# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_child_count())
	position = cartPositions[get_parent().get_child_count()-1]
	print("Test")
	print(position)
	scale.x = 2
	scale.y = 2
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
