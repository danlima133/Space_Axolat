extends Node
class_name PlayerAttetion

signal attetionStarted()
signal attetionFinished()
signal attetionConslusion()
signal attetionRefused()

onready var music = $music
onready var transition = $transition
onready var timer_to_conclusion = $timerToConclusion

var isAttetion = false
var gameOver = false

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.scancode:
				KEY_0:
					conslusionAttetion()
				KEY_1:
					attetion()

func attetion():
	if isAttetion or gameOver:
		emit_signal("attetionRefused")
	else:
		emit_signal("attetionStarted")
		timer_to_conclusion.start()
		transition.play("attetion-fadeIn")
		music.play()
		
		isAttetion = true

func conslusionAttetion():
	if isAttetion and !gameOver:
		transition.play("attetion-fadeOut")
		isAttetion = false
		emit_signal("attetionConslusion")
	
func _on_timerToConclusion_timeout():
	emit_signal("attetionFinished")
	gameOver = true

func _on_transition_animation_finished(anim_name):
	match anim_name:
		"attetion-fadeOut":
			music.stop()

func _on_attetionPlayer_attetionFinished():
	print("attetion_finished")

func _on_attetionPlayer_attetionConslusion():
	print("attetion_deny")

func _on_attetionPlayer_attetionRefused():
	print("attetion_refused")

func _on_attetionPlayer_attetionStarted():
	print("attetion_started")
