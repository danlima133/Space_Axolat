extends Node2D

onready var dash_timer = $dashTimer
onready var dash_safe = $dashSafe

onready var player = $".."
onready var sprite = $"../sprite"

export(float) var timeDash
export(int) var dash
export(float) var dashStrenght

var isDash = false
var canUseDash = true

func _ready():
	dash_timer.wait_time = timeDash
	dash_safe.cast_to.y = dash
	
func _process(delta):
	checkCanDash()

func checkCanDash():
	if dash_safe.is_colliding():
		canUseDash = false
	else:
		canUseDash = true
	dash_safe.rotation_degrees = 90 * player.getDirPlayer()

func getMoveDash() -> Tween:
	var moveDash = Tween.new()
	moveDash.name = "move"
	if player.getDirPlayer() == -1:
		moveDash.interpolate_property(player, "global_position", player.global_position, Vector2(player.global_position.x + dash, player.global_position.y), dashStrenght, Tween.TRANS_CUBIC)
	else:
		moveDash.interpolate_property(player, "global_position", player.global_position, Vector2(player.global_position.x - dash, player.global_position.y), dashStrenght, Tween.TRANS_CUBIC)
	return moveDash

func dash():
	isDash = true
	var move = getMoveDash()
	move.connect("tween_all_completed", self, "removeDashMove", [ move ])
	self.add_child(move)
	
	move.start()
	dash_timer.start()
	print("Can't use Dash")
	
func _input(event):
	if event.is_action_pressed("dashPlayer") and !isDash:
		if canUseDash: dash()

func _on_dashTimer_timeout():
	isDash = false
	print("Can use Dash")

func removeDashMove(move:Tween):
	move.queue_free()
