extends KinematicBody2D
class_name Player

onready var sprite = $sprite
onready var shape = $shape

export(int) var velocity = 100

var dir = Vector2.ZERO

func _physics_process(delta):
	
	dir = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown").normalized()
	dir *= velocity
	
	animMove()
	
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
