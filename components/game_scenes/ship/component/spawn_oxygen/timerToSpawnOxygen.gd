extends Timer

export(int) var timeMin = 0
export(int) var timeMax = 0
export(Array) var roomsId

onready var current_room = $"../currentRoom"
onready var alert = $"../UI/base/alert"
onready var timer_to_reset = $timerToReset

var choiceddRoom:String
var timerToReset = false

func _ready():
	setTime()

func setTime():
	wait_time = rand_range(timeMin, timeMax)
	start()

func choiceRoomToSpaw():
	choiceddRoom = roomsId[int(rand_range(0, roomsId.size()))]
	print("escolhei ", choiceddRoom)

func trySpawOxygen():
	if choiceddRoom == "": return
	
	if !timerToReset:
		timer_to_reset.start()
		timerToReset = true
	
	if current_room.get_child(0).has_node(choiceddRoom):
		var spaw = current_room.get_child(0).get_node(choiceddRoom)
		spaw.spawnOxygen()
		print("spaw to", choiceddRoom)
		choiceddRoom = ""
		setTime()
		timer_to_reset.stop()

func _on_timerToSpawnOxygen_timeout():
	choiceRoomToSpaw()
	
func _on_timerToReset_timeout():
	choiceddRoom = ""
	timerToReset = false
	setTime()
	print("reset")
