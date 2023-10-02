extends Area2D

func _ready():
	%WrongCrateWarning.hide()

var target : String

func setTarget(t):
	target = t

func _on_body_entered(body):
	if not body.has_meta("crate_type"): return
	if body.get_meta("crate_type") == target: return
	body.collision_layer = 2
	body.collision_mask = 0
	%WrongCrateWarning.show()

func _on_body_exited(body):
	if not body.has_meta("crate_type"): return
	body.collision_layer = 1
	body.collision_mask = 1
	%WrongCrateWarning.hide()
