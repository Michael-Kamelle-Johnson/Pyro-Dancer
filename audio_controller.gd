extends AudioStreamPlayer


var title_screen = preload("res://sound/temp/bgm/Sketchbook 2024-10-13.ogg")
var level_select = preload("res://sound/temp/bgm/Sketchbook 2024-12-05.ogg")


var level_music1 = preload("res://sound/temp/bgm/Sketchbook 2024-10-14.ogg")
var level_music2 = preload("res://sound/temp/bgm/Sketchbook 2024-10-23.ogg")
var level_music3 = preload("res://sound/temp/bgm/Sketchbook 2024-10-30.ogg")
var level_music4 = preload("res://sound/temp/bgm/Sketchbook 2024-11-20.ogg")


var previous_track = null
var current_track = null


var music_tracks = {
	1: level_music1,
	2: level_music2,
	3: level_music3,
	4: level_music4,
	10: title_screen,
	20: level_select
	
}



func _ready() -> void:
	pass
	
	
	

func select_music(music_number: int):
	if music_tracks.has(music_number):
		stream = music_tracks[music_number]
		previous_track = current_track
		current_track = music_tracks[music_number]
	else:
		stream = title_screen
	
	if stream != null:
		play()
		
		
	
		
		
	
	
	
	
