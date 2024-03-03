extends MeshInstance3D

@export var playerParameters : PlayerParameters

func _process(delta):
	if playerParameters.THIRD_PERSON_CAMERA:
		visible = true
	else:
		visible = false	
