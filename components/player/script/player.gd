extends KinematicBody2D
class_name Player

onready var sprite = $sprite

onready var dash = $dash
onready var shape = $shape

export(int) var velocity = 100

var dir = Vector2.ZERO
var dirInput = Vector2.ZERO

var ship
var dataShare
var attetionPlayer:PlayerAttetion

func _enter_tree():
	ship = get_tree().get_nodes_in_group("Ship")[0]
	ship.getDataShare().connect("oxygenPlayerState", self, "oxygenState", [ ship.getDataShare() ])
	
	dataShare = ship.get_node("dataShare")
	
	attetionPlayer = ship.get_node("attetionPlayer")
	attetionPlayer.connect("attetionFinished", self, "noOxygen")

func _physics_process(delta):
	dir = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown").normalized()
	dirInput = dir
	dir *= velocity
	
	animMove()
	
	if !dash.has_node("move"):
		dir = move_and_slide(dir)

func animMove():
	if dir != Vector2.ZERO:
		sprite.play("run")
		if dir.x > 0:
			sprite.flip_h = false
			shape.position.x = -1
		elif dir.x < 0:
			sprite.flip_h = true
			shape.position.x = 1
	else:
		sprite.play("idle")

func getDirPlayer() -> int:
	if sprite.flip_h == true:
		return 1
	return (-1)

func oxygenState(state, shipData:ShipData):
	print(state)
	if state == 0:
		print("No oxygen")

func noOxygen():
	if !dataShare.hasOxygen:
		queue_free()
