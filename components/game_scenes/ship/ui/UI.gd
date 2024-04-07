extends CanvasLayer

onready var data_share = $"../dataShare"

onready var player_oxygen = $base/playerOxygen

func _ready():
	player_oxygen.text = str(data_share.playerCurrentOxygen)

func _on_dataShare_oxygenPlayerState(state):
	player_oxygen.text = str(state)
