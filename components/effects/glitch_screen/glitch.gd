extends ColorRect

onready var anim = $anim

func startEffect(to:float):
	anim.interpolate_property(self.material, "shader_param/shake_rate", 0, to, 47, Tween.TRANS_LINEAR)
	anim.start()

func removeEffect():
	var back = Tween.new()
	add_child(back)
	
	back.interpolate_property(self.material, "shader_param/shake_rate", self.material.get("shader_param/shake_rate"), 0, 1, Tween.TRANS_LINEAR)
	back.start()
	
	yield(back, "tween_all_completed")
	
	queue_free()
