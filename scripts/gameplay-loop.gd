extends Node

signal target_crate_type_changed(crateType : String)

var typeTargetOrder : Array
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
	typeTargetOrder = $/root/World.crateTypes.duplicate()
	typeTargetOrder.shuffle()
	nextTarget()

func nextTarget():
	if typeTargetOrder.is_empty(): return onWin()
	targetCrateType = typeTargetOrder.pop_back()
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
	var combinedScore = timeScore * accuracyScore * accuracyScore
	%CratesShippedLabel.text = "%d/%d" % [cratesShipped, totalCrates]
	%ScoreLabel.text = "%d" % combinedScore
	%LevelNameLabel.text = levelName
	%WinScreen.show()
