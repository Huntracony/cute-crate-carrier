extends Node

signal target_crate_type_changed(crateType : String)

var remainingCrateTypes : Array
var targetCrateType : String

var totalCrates : int
var cratesLost : int
var cratesShipped : int
var levelName : String
var startTime : int
var gameActive = false

func start():
	%WinScreen.hide()
	randomize()
	
	# Remove any remaining crates
	for crate in %CrateContainer.get_children():
		crate.removeSelf()
	print(%CrateContainer.get_children())
	
	# Load random level
	var levelFolderPath = "res://levels"
	var levels = Array(DirAccess.get_files_at(levelFolderPath))
	levels = levels.filter(func(f): return f.ends_with(".level.json"))
	levelName = levels[ randi() % levels.size() ]
	var levelPath = levelFolderPath + "/" + levelName
	print("loading from: " + levelPath)
	totalCrates = $/root/World.loadLevel(levelPath)
	
	cratesLost = 0
	cratesShipped = 0
	startTime = Time.get_ticks_msec()
	gameActive = true
	remainingCrateTypes = $/root/World.crateTypes.duplicate()
	nextTarget()

func nextTarget():
	var lowestTarget = ""
	var lowestTargetHeight = -INF
	for type in remainingCrateTypes:
		var crates = get_tree().get_nodes_in_group(type)
		if crates.is_empty(): continue
		var crateHeights = 0.0
		for cr in crates:
			crateHeights += cr.position.y
		crateHeights /= crates.size()
		if crateHeights > lowestTargetHeight:
			lowestTarget = type
			lowestTargetHeight = crateHeights
	if lowestTarget == "": return onWin()
	targetCrateType = lowestTarget
	remainingCrateTypes.erase(targetCrateType)
	target_crate_type_changed.emit(targetCrateType)

func clearTargetCrates():
	for crate in get_tree().get_nodes_in_group(targetCrateType):
		crate.removeSelf()
		cratesShipped += 1

func _physics_process(_delta):
	if not gameActive: return
	if %WinArea.haveWon(targetCrateType):
		clearTargetCrates()
		nextTarget()

func onCrateLost(crate):
	if not crate.has_meta("crate_type"): return
	cratesLost += 1
	crate.removeSelf()

func onWin():
	gameActive = false
	var secondsElapsed = float(Time.get_ticks_msec() - startTime)/1000
	var timeScore = 100_000 / (secondsElapsed + 30.0)
	var accuracyScore = float(cratesShipped)/float(totalCrates)
	var completionBonus = 150 if accuracyScore == 1.0 else 0
	var combinedScore = timeScore * accuracyScore * accuracyScore + completionBonus
	%CratesShippedLabel.text = "%d/%d" % [cratesShipped, totalCrates]
	%ScoreLabel.text = "%d" % combinedScore
	%LevelNameLabel.text = levelName
	%WinScreen.show()
