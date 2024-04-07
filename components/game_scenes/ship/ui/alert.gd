extends CanvasLayer

onready var conatiner = $base/conatiner

const mensagemTemplate = preload("res://components/game_scenes/ship/ui/alerts_obj/alertMensage.tscn")

var hasAlert = false

func alert(mensage:Dictionary, isCancel = true):
	if conatiner.get_child_count() > 0:
		if !isCancel:
			return false
		conatiner.get_child(0).queue_free()
	
	hasAlert = true
	
	var alert = mensagemTemplate.instance()
	conatiner.add_child(alert)
	alert.get_node("title").text = mensage["title"]
	alert.get_node("subTitle").text = mensage["sub_title"]
	
	alert.get_node("anim").play("alert")
	if isCancel: alert.get_node("anim").connect("animation_finished", self, "alertFinished", [ alert ])
	
	return true

func alertFinished(anim_name, alert):
	if hasAlert:
		alert.get_node("anim").play_backwards("alert")
		hasAlert = false
	else:
		alert.queue_free()
