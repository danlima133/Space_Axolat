extends Node
class_name PlayerAttetion

signal attetionStarted()
signal attetionFinished()
signal attetionConslusion()
signal attetionRefused()

const templateGlithcEffect = preload("res://components/effects/glitch_screen/glitch.tscn")

onready var music = $music
onready var transition = $transition
onready var timer_to_conclusion = $timerToConclusion

onready var ui = $"../UI/base"

var isAttetion = false
var gameOver = false

var glitchEffect

func attetion():
	if isAttetion or gameOver:
		emit_signal("attetionRefused")
	else:
		emit_signal("attetionStarted")
		
		glitchEffect = templateGlithcEffect.instance()
		ui.add_child(glitchEffect)
		
		timer_to_conclusion.start()
		transition.play("attetion-fadeIn")
		music.play()
		glitchEffect.startEffect(timer_to_conclusion.wait_time)
		
		isAttetion = true

func conslusionAttetion():
	if isAttetion and !gameOver:
		transition.play("attetion-fadeOut")
		isAttetion = false
		if glitchEffect != null:
			glitchEffect.removeEffect()
		emit_signal("attetionConslusion")
	
func _on_timerToConclusion_timeout():
	emit_signal("attetionFinished")
	if glitchEffect != null:
		glitchEffect.removeEffect()
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
