extends Area2D

export(String) var room_id

var ship

func _enter_tree():
	ship = get_tree().get_nodes_in_group("Ship")[0]

func _on_changeScene_body_entered(body):
	if body is Player:
		ship.changeRoom(room_id)
