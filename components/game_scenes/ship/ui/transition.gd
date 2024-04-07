extends CanvasLayer

signal transitionStarted(id)
signal transitionFinished(id)

onready var anim = $anim

var isTransition = false

const transitions = {
	"Fade": "fade-black"
}

func executeTransition(id:String, back = false, speed = 1) -> bool:
	if isTransition: return false
	
	isTransition = true
	
	var animName = transitions[id]
	if !back:
		anim.play(animName)
	else: anim.play_backwards(animName)
	anim.playback_speed = speed
	emit_signal("transitionStarted", id)
	
	yield(anim, "animation_finished")
	
	isTransition = false
	emit_signal("transitionFinished", id)
	
	return true
