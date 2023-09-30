extends Node2D

var containerScene = preload("res://container.tscn")

func _input(event):
	if not event is InputEventMouseButton: return
	if not event.pressed or event.button_index != 2: return
	var container = containerScene.instantiate()
	container.position = %ContainerContainer.get_local_mouse_position()
	%ContainerContainer.add_child(container)
