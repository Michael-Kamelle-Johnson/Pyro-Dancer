extends Node



signal camera_shake
signal screen_transition

signal player_death

signal level_finished
signal next_scene
signal reset_scene

signal do_gba_filter

var level = 1

var isGBAFILTER: bool = false


func play_local_sound(stream: AudioStreamPlayer2D, pitch = 1):
	stream.pitch_scale = pitch
	
	if !stream.playing:
		stream.play()


func stop_local_sound(stream: AudioStreamPlayer2D):
	if stream.playing:
		stream.stop()


func play_sound(stream: AudioStreamPlayer, pitch = 1):
	stream.pitch_scale = pitch
	
	if !stream.playing:
		stream.play()
		
		
func stop_sound(stream: AudioStreamPlayer, pitch = 1):
	if stream.playing:
		stream.stop()



func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("gba_toggler"):
		if Globals.isGBAFILTER == false:
			Globals.isGBAFILTER = true
			do_gba_filter.emit()
		else:
			Globals.isGBAFILTER = false
			do_gba_filter.emit()
