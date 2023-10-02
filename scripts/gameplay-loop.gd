extends Node

signal target_crate_type_changed(crateType : String)

var typeTargetOrder : Array
var targetCrateType : String

var totalCrates : int
var cratesLost : int
var cratesShipped : int

func start():
	randomize()
	
	# Remove any remaining crates
	for crate in %CrateContainer.get_children():
		crate.removeSelf()
	print(%CrateContainer.get_children())
	
	# Load random level
	var levelFolderPath = "res://levels"
	var levels = Array(DirAccess.get_files_at(levelFolderPath))
	levels = levels.filter(func(f): return f.ends_with(".level.json"))
	var chosenLevel = levels[ randi() % levels.size() ]
	var levelPath = levelFolderPath + "/" + chosenLevel
	print("loading from: " + levelPath)
	totalCrates = $/root/World.loadLevel(levelPath)
	
	cratesLost = 0
	cratesShipped = 0
	typeTargetOrder = $/root/World.crateTypes.duplicate()
	typeTargetOrder.shuffle()
	nextTarget()

func nextTarget():
	if typeTargetOrder.is_empty(): return start()
	targetCrateType = typeTargetOrder.pop_back()
	target_crate_type_changed.emit(targetCrateType)

func clearTargetCrates():
	for crate in get_tree().get_nodes_in_group(targetCrateType):
		crate.removeSelf()
		cratesShipped += 1

func _physics_process(_delta):
	if %WinArea.haveWon(targetCrateType):
		clearTargetCrates()
		nextTarget()

func onCrateLost(crate):
	if not crate.has_meta("crate_type"): return
	cratesLost += 1
	crate.removeSelf()
