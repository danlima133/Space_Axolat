extends Timer

export(int) var timeMin = 0
export(int) var timeMax = 0
export(Array) var roomsId

onready var current_room = $"../currentRoom"
onready var alert = $"../UI/base/alert"
onready var timer_to_reset = $timerToReset

var choiceddRoom:String
var timerToReset = false
var lastPosOxygen = -1

func _ready():
	setTime()

func setTime():
	wait_time = rand_range(timeMin, timeMax)
	start()

func choiceRoomToSpaw():
	choiceddRoom = roomsId[int(rand_range(0, roomsId.size()))]
	print("escolhi ", choiceddRoom)
	timer_to_reset.start()

func trySpawOxygen(spawOxygen):
	if choiceddRoom == "": return
	
	if !timerToReset:
		timer_to_reset.start()
		timerToReset = true
	
	if spawOxygen.spawId == choiceddRoom:
		spawOxygen.spawnOxygen(lastPosOxygen)
		print("spaw to", choiceddRoom)

func _on_timerToSpawnOxygen_timeout():
	choiceRoomToSpaw()
	
func _on_timerToReset_timeout():
	choiceddRoom = ""
	timerToReset = false
	lastPosOxygen = -1
	setTime()
	print("reset")
