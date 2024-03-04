class_name Room3D extends Node3D

var connectorList : Array

func _fill_con_list() -> void:
	connectorList = get_node("Targets").get_children()
