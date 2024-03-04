class_name Connector3D extends Marker3D

var isOccupied : bool = false

func _process(delta):
	if isOccupied:
		get_child(0).visible = true
