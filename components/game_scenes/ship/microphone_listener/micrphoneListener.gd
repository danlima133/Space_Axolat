extends Node
class_name MicrophoneListener

signal microphoneListenerActive(device)
signal microphoneListenerDesactive()

const busListener = "Listener"

var listener:AudioEffectRecord

var _active = true

func _ready():
	startListener()

func _process(delta):
	var sample = AudioServer.get_bus_peak_volume_left_db(AudioServer.get_bus_index(busListener), 0)

func startListener():
	if _active:
		var busIdx = AudioServer.get_bus_index(busListener)
		listener = AudioServer.get_bus_effect(busIdx, 0) as AudioEffectRecord
		emit_signal("microphoneListenerActive", AudioServer.capture_device)
	else: emit_signal("microphoneListenerDesactive")

func setMicrophoneListener(value:bool):
	if _active:
		listener.set_recording_active(value)

func setDevice(device):
	AudioServer.capture_device = device

func getDeviceListener():
	return AudioServer.capture_get_device_list()

func _on_micrphoneListener_microphoneListenerActive(device):
	setMicrophoneListener(true)
