extends Label

var target = "tiger"

func _process(_delta):
	if %WinArea.haveWon(target):
		text = "yes"
	else:
		text = "no"
