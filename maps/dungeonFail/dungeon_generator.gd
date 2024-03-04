extends Node3D

@export var roomList = []
@onready var roomContainer = get_node("roomsContainer")

func add_room():
	randomize()
	if roomContainer.get_child_count() == 0:
		var room : Room3D = roomList.pick_random().instantiate()
		room._fill_con_list()
		roomContainer.add_child(room)
	else:
		var existingRoom = roomContainer.get_children().pick_random()  # before instantiating
		var openConnector : Connector3D
		
		while openConnector == null:
			openConnector = check_connectors(existingRoom)
			if openConnector == null:
				existingRoom = roomContainer.get_children().pick_random()
		# maybe when no connections left do something
		
		var room : Room3D = roomList.pick_random().instantiate()
		room._fill_con_list()
		var roomConnector : Connector3D = room.connectorList.pick_random()
		roomContainer.add_child(room)
		
		roomConnector.isOccupied = true
		openConnector.isOccupied = true
		
		#position room
		room.position = openConnector.global_position
		room.translate(roomConnector.position * -1)
		
		#rotate room
		var model = room.find_child("Model")
		model.reparent(roomConnector)
		for otherConnector : Connector3D in room.connectorList:
			if !otherConnector.isOccupied:
				otherConnector.reparent(roomConnector)
		
		
		

func check_connectors(room : Room3D):
	for connector : Connector3D in room.connectorList:
			if !connector.isOccupied:
				return connector

func rotateAround(obj, point, axis, angle):
	var rot = angle + obj.rotation.y 
	var tStart = point
	obj.global_translate (-tStart)
	obj.transform = obj.transform.rotated(axis, -rot)
	obj.global_translate (tStart)

func _on_button_pressed():
	add_room()

