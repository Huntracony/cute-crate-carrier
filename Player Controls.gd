extends Node2D


var conts = preload("res://Container_object.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
#	var something = conts.instantiate()
#	%Containers_Container.add_child(something)
#	var something2 = conts.instantiate()
#	%Containers_Container.add_child(something2)
	pass


func _input(event):
#	if event is InputEventMouseButton:
##		print("Mouse Click/Unclick at: ", event.position)
#		var something = conts.instantiate()
#		%Containers_Container.add_child(something)
#	elif event is InputEventMouseMotion:
#
#		print("Mouse Motion at: ", event.position)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var test:bool = false
	
	if test == true:
		var something = conts.instantiate()
		%Containers_Container.add_child(something)
	pass
