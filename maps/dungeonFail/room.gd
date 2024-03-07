class_name Room3D extends Node3D

var connectorList : Array

func _fill_con_list() -> void:
	if len(connectorList) == 0:
		connectorList = get_node("Targets").get_children()
	else:
		connectorList.clear()
		for node in get_node("Targets").get_children()[0].get_children():
			if node.is_class("Marker3D"):
				connectorList.append(node)

func _change_rotating_root(connector : Connector3D) -> void:
	if connector in connectorList:
		var model = get_node("Model")
		model.reparent(connector)
		for leftConnector : Connector3D in get_node("Targets").get_children():
			if !leftConnector.isOccupied:
				leftConnector.reparent(connector)
		_fill_con_list()
	else:
		printerr("No connector in the list!")
