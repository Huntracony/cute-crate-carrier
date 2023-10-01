extends Area2D

var target = "tiger"

func _physics_process(_delta):
	pass
#	print(haveWon())

# TODO: check at rest and not being held
func haveWon():
	var targetCratesFound = 0
	var targetCratesTotal = get_tree().get_nodes_in_group(target).size()
	for bod in get_overlapping_bodies():
		if not bod.has_meta("crate_type"): continue
		if not bod.get_meta("crate_type") == target: return false
		targetCratesFound += 1
	return targetCratesFound == targetCratesTotal
