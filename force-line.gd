extends Line2D

func setLine(a, b, intensity):
	print(intensity)
	points = PackedVector2Array([(a), (b)])
	var hue = (1-intensity)/3
	default_color = Color.from_hsv(hue, 1.0, 1.0, 0.5)
	show()
