extends Node3D

@export var roomList = []
@export var roomContainer : Node3D
var toggleGenerator : bool = false
var ppCount : float = 0.0

func add_room() -> void:
	randomize()
	if roomContainer.get_child_count() == 0:
		var room : Room3D = roomList.pick_random().instantiate()
		room._fill_con_list()
		roomContainer.add_child(room)
		room.roomBounderies.monitoring = false
	else:
		var roomContainerArray = roomContainer.get_children()
		roomContainerArray[roomContainer.get_child_count() - 1].roomBounderies.monitoring = false
		var existingRoom = roomContainerArray.pick_random()  # before instantiating
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
		room._change_rotating_root(roomConnector)
		roomConnector.global_rotation[1] = openConnector.global_rotation[1] + PI


func check_connectors(room : Room3D):
	for connector : Connector3D in room.connectorList:
			if !connector.isOccupied:
				return connector

func _on_button_pressed():
	add_room()

func _on_generate_pressed():
	toggleGenerator = !toggleGenerator

func _physics_process(delta):
	if toggleGenerator and ppCount > 0.2:
		ppCount = 0.0
		add_room()
	else:
		ppCount += delta
