extends Area2D

const MAX_VELOCITY_SQ = 5.0 ** 2

func haveWon(target):
	var targetCratesFound = 0
	var targetCratesTotal = get_tree().get_nodes_in_group(target).size()
	for bod in get_overlapping_bodies():
		if not bod.has_meta("crate_type"): continue
		if not bod.get_meta("crate_type") == target: return false
		if bod.grabbed: return false
		if bod.linear_velocity.length_squared() > MAX_VELOCITY_SQ: return false
		targetCratesFound += 1
	return targetCratesFound == targetCratesTotal
