extends Node
class_name ShipData

signal oxygenPlayerState(state)

export(int) var maxOxygen
export(Dictionary) var playerOxygenData = {
	"valueMin": 0,
	"valueMax": 0,
	"timerMin": 0,
	"timerMax":0
}

onready var oxygen_timer = $oxygenTimer
onready var player_oxygen = $"../UI/base/playerOxygen"
onready var attetion_player = $"../attetionPlayer"

onready var alert = $"../UI/base/alert"

var current_room:String
var playerCurrentOxygen:int
var hasOxygen = true

func _ready():
	playerCurrentOxygen = maxOxygen
	setTimeToOxygen()

func setTimeToOxygen():
	oxygen_timer.wait_time = rand_range(playerOxygenData["timerMin"], playerOxygenData["timerMax"])
	oxygen_timer.start()

func consumableOxygen(value:int):
	if playerCurrentOxygen > value:
		playerCurrentOxygen -= value
		emit_signal("oxygenPlayerState", playerCurrentOxygen)
	else:
		if hasOxygen:
			emit_signal("oxygenPlayerState", 0)
			hasOxygen = false

func addOxygen(value:int):
	if value == 0: return false
	
	hasOxygen = true
	playerCurrentOxygen += value
	playerCurrentOxygen = clamp(playerCurrentOxygen, 0, maxOxygen)
	setTimeToOxygen()
	emit_signal("oxygenPlayerState", playerCurrentOxygen)

func consumableAutoOxygen():
	consumableOxygen(rand_range(playerOxygenData["valueMin"], playerOxygenData["valueMax"]))

func _on_oxygenTimer_timeout():
	consumableAutoOxygen()
	setTimeToOxygen()

func _on_dataShare_oxygenPlayerState(state):
	if state == 0:
		alert.alert({ "title": "Oxygen Alert", "sub_title": "O seu oxigenio reserva acabou"})
		attetion_player.attetion()
