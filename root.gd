extends Node2D

var crateScenes = [
	preload("res://crates/fox-crate.tscn"),
	preload("res://crates/frog-crate.tscn"),
	preload("res://crates/koala-crate.tscn"),
	preload("res://crates/lion-crate.tscn"),
	preload("res://crates/panda-crate.tscn"),
	preload("res://crates/red-panda-crate.tscn"),
	preload("res://crates/reindeer-crate.tscn"),
	preload("res://crates/sera-crate.tscn"),
	preload("res://crates/sloth-crate.tscn"),
	preload("res://crates/tiger-crate.tscn")
]

func _input(event):
	if not event is InputEventMouseButton: return
	if not event.pressed or event.button_index != 2: return
	var packedScene = crateScenes[ randi() % crateScenes.size() ]
	var crate = packedScene.instantiate()
	crate.position = %CrateContainer.get_local_mouse_position()
	crate.crateHeld.connect(%ForceLine.setLine)
	crate.crateReleased.connect(%ForceLine.hide)
	crate.add_to_group(crate.get_meta("crate_type"))
	%CrateContainer.add_child(crate)
