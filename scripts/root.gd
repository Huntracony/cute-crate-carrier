extends Node2D

var trainScene = preload("res://scenes/train_cart.tscn")

var crateScenes = {
	fox = preload("res://crates/fox-crate.tscn"),
	frog = preload("res://crates/frog-crate.tscn"),
	koala = preload("res://crates/koala-crate.tscn"),
	lion = preload("res://crates/lion-crate.tscn"),
	panda = preload("res://crates/panda-crate.tscn"),
	"red panda" = preload("res://crates/red-panda-crate.tscn"),
	reindeer = preload("res://crates/reindeer-crate.tscn"),
	sera = preload("res://crates/sera-crate.tscn"),
	sloth = preload("res://crates/sloth-crate.tscn"),
	tiger = preload("res://crates/tiger-crate.tscn")
}

var crateTypes = crateScenes.keys()

func _ready():
	if not OS.is_debug_build():
		%DebugUI.hide()
	%GameplayLoop.start()

func _input(event):
	if not event is InputEventMouseButton: return
#	%GameplayLoop
#	if event.pressed and event.button_index == 1 && %CartContainer.get_child_count() < 2:
#		var new_train = trainScene.instantiate()
#		%CartContainer.add_child(new_train)
	
	if not OS.is_debug_build(): return
	if not event.pressed or event.button_index != 2: return
	var crateType = crateTypes[ randi() % crateTypes.size() ]
	var trans = Transform2D(0, %CrateContainer.get_local_mouse_position())
	spawnCrate(crateType, trans)

func spawnCrate(type : String, trans : Transform2D):
	var scene = crateScenes[type]
	var crate = scene.instantiate()
	crate.crateHeld.connect(%ForceLine.setLine)
	crate.crateReleased.connect(%ForceLine.hide)
	crate.add_to_group(type)
	%CrateContainer.add_child(crate)
	crate.transform = trans
	return crate

func saveLevel():
	var saveDict = {
		version = 1.0,
		crates = { }
	}
	for type in crateTypes:
		saveDict.crates[type] = []
	
	for crate in %SaveArea.get_overlapping_bodies():
		if not crate.has_meta("crate_type"): continue
		var trans : Transform2D = crate.transform
		var flattened = [
			trans.x.x, trans.x.y,
			trans.y.x, trans.y.y,
			trans.origin.x, trans.origin.y
		]
		saveDict.crates[crate.get_meta("crate_type")].append(flattened)
	
	var saveText = JSON.stringify(saveDict)
	var savePath = "res://levels/%s.level.json" % saveText.md5_text()
	print("saving to: " + savePath)
	var saveFile = FileAccess.open(savePath, FileAccess.WRITE)
	saveFile.store_string(saveText)

func loadLevel(savePath):
	assert( %CrateContainer.get_children().size() == 0 )
	var saveFile = FileAccess.open(savePath, FileAccess.READ)
	var saveText = saveFile.get_as_text()
	var saveDict = JSON.parse_string(saveText)
	assert(saveDict.version == 1.0)
	
	var totalCrates = 0
	for type in crateTypes:
		for flat in saveDict.crates[type]:
			assert(flat.size() == 6)
			var trans = Transform2D(
				Vector2(flat[0], flat[1]),
				Vector2(flat[2], flat[3]),
				Vector2(flat[4], flat[5])
			)
			var _crate = spawnCrate(type, trans)
			totalCrates += 1
#			assert(%SaveArea.overlaps_body(_crate))
	return totalCrates
