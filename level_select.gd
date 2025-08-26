extends Control



func _ready() -> void:
	
	if AudioController.stream == AudioController.title_screen:
		AudioController.select_music(1)
	
	if Globals.level >= 1:
		$LVLMarginContainer/LevelContainer/LVL1.show()
	if Globals.level >= 2:
		$LVLMarginContainer/LevelContainer/LVL2.show()
	if Globals.level >= 3:
		$LVLMarginContainer/LevelContainer/LVL3.show()
	if Globals.level >= 4:
		$LVLMarginContainer/LevelContainer/LVL4.show()
	if Globals.level >= 5:
		$LVLMarginContainer/LevelContainer/LVL5.show()
	if Globals.level >= 6:
		$LVLMarginContainer/LevelContainer/LVL6.show()
	if Globals.level >= 7:
		$LVLMarginContainer/LevelContainer/LVL7.show()
	#if Globals.level >= 8:
		#$LVLMarginContainer/LevelContainer/LVL8.show()
	






func _on_lvl_1_pressed() -> void:
	if AudioController.current_track != AudioController.level_music2:
		AudioController.select_music(2)
	get_tree().change_scene_to_file("res://level/level1.tscn")


func _on_lvl_2_pressed() -> void:
	if AudioController.current_track != AudioController.level_music2:
		AudioController.select_music(2)
	get_tree().change_scene_to_file("res://level/level2.tscn")


func _on_lvl_3_pressed() -> void:
	if AudioController.current_track != AudioController.level_music3:
		AudioController.select_music(3)
	
	get_tree().change_scene_to_file("res://level/level3.tscn")


func _on_lvl_4_pressed() -> void:
	if AudioController.current_track != AudioController.level_music3:
		AudioController.select_music(3)
	
	get_tree().change_scene_to_file("res://level/level4.tscn")


func _on_lvl_5_pressed() -> void:
	if AudioController.current_track != AudioController.level_music4:
		AudioController.select_music(4)
	
	get_tree().change_scene_to_file("res://level/level5.tscn")


func _on_lvl_6_pressed() -> void:
	if AudioController.current_track != AudioController.level_music4:
		AudioController.select_music(4)
	
	get_tree().change_scene_to_file("res://level/level6.tscn")

func _on_lvl_7_pressed() -> void:
	if AudioController.current_track != AudioController.level_music4:
		AudioController.select_music(4)
	
	get_tree().change_scene_to_file("res://level/level7.tscn")


func _on_return_to_title_pressed() -> void:
	get_tree().change_scene_to_file("res://title_screen.tscn")
