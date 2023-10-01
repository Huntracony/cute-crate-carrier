extends Node2D

var crateScene = preload("res://crate.tscn")

func _input(event):
	if not event is InputEventMouseButton: return
	if not event.pressed or event.button_index != 2: return
	var crate = crateScene.instantiate()
	crate.position = %CrateContainer.get_local_mouse_position()
	%CrateContainer.add_child(crate)
