extends Node

const templateOxygen = preload("res://components/game_scenes/ship/component/oxygenCore/oxygenCore.tscn")

export(String) var spawId

onready var positions = $positions

var ship

func _enter_tree():
	ship = get_tree().get_nodes_in_group("Ship")[0]

func _ready():
	randomize()
	ship.get_node("timerToSpawnOxygen").trySpawOxygen(self)

func spawnOxygen(idxPos:int = -1):
	var pos:Position2D
	
	if idxPos == -1:
		var idx = int(rand_range(0, positions.get_child_count()))
		pos = positions.get_child(idx)
		ship.get_node("timerToSpawnOxygen").lastPosOxygen = idx
	else:
		pos = positions.get_child(idxPos)
	
	var oxygen = templateOxygen.instance()
	oxygen.global_position = pos.global_position
	pos.add_child(oxygen)
	
