extends KinematicBody2D

onready var sprite = $sprite

onready var dash = $dash
onready var shape = $shape

export(int) var velocity = 100

var dir = Vector2.ZERO
var dirInput = Vector2.ZERO

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

func _physics_process(delta):
	dir = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown").normalized()
	dirInput = dir
	dir *= velocity
	
	animMove()
	
	if !dash.has_node("move"):
		dir = move_and_slide(dir)
