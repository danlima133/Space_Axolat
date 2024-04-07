extends Area2D

export(int) var countMin
export(int) var countMax

var ship:ShipData

func shipData() -> ShipData:
	return get_tree().get_nodes_in_group("Ship")[0].get_node("dataShare") as ShipData

func ship():
	return get_tree().get_nodes_in_group("Ship")[0]

func playerAttetion() -> PlayerAttetion:
	return get_tree().get_nodes_in_group("Ship")[0].get_node("attetionPlayer") as PlayerAttetion

func _on_oxygenCore_body_entered(body):
	if body is Player:
		if shipData().hasOxygen == false:
			playerAttetion().conslusionAttetion()
			ship().get_node("UI/base/alert").alert({ "title":"Oxygen recover", "sub_title":"Voce recuperou o seu oxigenio reserva"})
		shipData().addOxygen(rand_range(countMin, countMax))
		queue_free()
