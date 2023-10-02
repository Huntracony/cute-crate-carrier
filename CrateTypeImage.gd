extends TextureRect

var crateTextures = {
	fox = preload("res://crates/fox-crate.png"),
	frog = preload("res://crates/frog-crate.png"),
	koala = preload("res://crates/koala-crate.png"),
	lion = preload("res://crates/lion-crate.png"),
	panda = preload("res://crates/panda-crate.png"),
	"red panda" = preload("res://crates/red-panda-crate.png"),
	reindeer = preload("res://crates/reindeer-crate.png"),
	sera = preload("res://crates/sera-crate.png"),
	sloth = preload("res://crates/sloth-crate.png"),
	tiger = preload("res://crates/tiger-crate.png")
}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var crateType = %GameplayLoop.targetCrateType
#	match c
	texture = crateTextures[crateType]
	
	pass
