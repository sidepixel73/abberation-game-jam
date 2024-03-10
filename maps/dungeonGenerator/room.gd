class_name Room3D extends Node3D

var connectorList : Array
@export var connectorNodes : Node3D
@export var roomModelAndEntities : Node3D

func _fill_con_list() -> void:
	if len(connectorList) == 0:
		connectorList = connectorNodes.get_children()
	else:
		connectorList.clear()
		for node in connectorNodes.get_children()[0].get_children():
			if node.is_class("Marker3D"):
				connectorList.append(node)

func _change_rotating_root(connector : Connector3D) -> void:
	if connector in connectorList:
		var model = roomModelAndEntities
		model.reparent(connector)
		for leftConnector : Connector3D in connectorNodes.get_children():
			if !leftConnector.isOccupied:
				leftConnector.reparent(connector)
		_fill_con_list()
	else:
		printerr("No connector in the list!")
