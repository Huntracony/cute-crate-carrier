extends Node2D

var trainScene = preload("res://scenes/train_cart.tscn")

var crateScenes = {
	"fox": preload("res://crates/fox-crate.tscn"),
	"frog": preload("res://crates/frog-crate.tscn"),
	"koala": preload("res://crates/koala-crate.tscn"),
	"lion": preload("res://crates/lion-crate.tscn"),
	"panda": preload("res://crates/panda-crate.tscn"),
	"red panda": preload("res://crates/red-panda-crate.tscn"),
	"reindeer": preload("res://crates/reindeer-crate.tscn"),
	"sera": preload("res://crates/sera-crate.tscn"),
	"sloth": preload("res://crates/sloth-crate.tscn"),
	"tiger": preload("res://crates/tiger-crate.tscn")
}

var crateTypes = crateScenes.keys()

func _input(event):
	if not event is InputEventMouseButton: return
	if event.pressed and event.button_index == 1 && %CartContainer.get_child_count() < 3:
		var new_train = trainScene.instantiate()
		%CartContainer.add_child(new_train)
	if not event.pressed or event.button_index != 2: return
	var crateType = crateTypes[ randi() % crateTypes.size() ]
	var transform = Transform2D(0, get_global_mouse_position())
	spawnCrate(crateType, transform)

func spawnCrate(type : String, transform : Transform2D):
	var scene = crateScenes[type]
	var crate = scene.instantiate()
	crate.crateHeld.connect(%ForceLine.setLine)
	crate.crateReleased.connect(%ForceLine.hide)
	crate.add_to_group(type)
	%CrateContainer.add_child(crate)
	crate.global_transform = transform
