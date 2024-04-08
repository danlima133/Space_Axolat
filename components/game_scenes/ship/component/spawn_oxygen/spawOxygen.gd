extends Node

const templateOxygen = preload("res://components/game_scenes/ship/component/oxygenCore/oxygenCore.tscn")

export(String) var spawId

onready var positions = $positions

var ship

func _enter_tree():
	ship = get_tree().get_nodes_in_group("Ship")[0]

func _ready():
	name = spawId
	randomize()
	ship.get_node("timerToSpawnOxygen").trySpawOxygen()

func spawnOxygen():
	var pos = positions.get_children()[int(rand_range(0, positions.get_child_count()-1))]
	var oxygen = templateOxygen.instance()
	
	oxygen.global_position = pos.global_position
	pos.add_child(oxygen)
	
