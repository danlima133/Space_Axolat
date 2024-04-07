extends Node
class_name Ship

export(String) var room_default

const rooms = {
	"Teste": preload("res://game_scenes/test/GameTest.tscn"),
	"Teste2": preload("res://game_scenes/test/GameTest2.tscn")
}

onready var data_share = $dataShare

onready var current_room = $currentRoom
onready var transition = $UI/base/transition

func _ready():
	if room_default != "":
		changeRoom(room_default)
	else: printerr("No scene default to start!")

func changeRoom(id:String) -> bool:
	if transition.executeTransition("Fade"):
		
		yield(transition, "transitionFinished")
		
		if current_room.get_child_count() > 0:
			getCurrentScene().queue_free()
		
		var room = rooms[id].instance()
		current_room.add_child(room)
			
		transition.executeTransition("Fade", true, 0.5)
		data_share.current_room = id
		
		return true
	return false

func getCurrentScene() -> Object:
	if current_room.get_child_count() > 0:
		return current_room.get_child(0)
	return null

func getDataShare() -> ShipData:
	return data_share
