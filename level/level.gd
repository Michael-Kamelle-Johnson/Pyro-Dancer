extends Node2D






func _ready() -> void:
	Globals.level_finished.connect(_on_level_end)
	Globals.next_scene.connect(_on_next_scene)
	_check_gba_filter()
	
	


func _check_gba_filter():
	if Globals.isGBAFILTER == true:
		if get_node("CanvasModulate") != null:
			$CanvasModulate.hide()
	else:
		if get_node("CanvasModulate") != null:
			$CanvasModulate.show()
		



func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("restart_key"):
		Globals.reset_scene.emit()
		get_tree().reload_current_scene()
		
		
	if Input.is_action_just_pressed("level_select_key"):
		get_tree().change_scene_to_file("res://level_select.tscn")


func _on_level_end():
	if Globals.level < 7:
		Globals.level += 1
	
	
	Globals.screen_transition.emit()


func _on_next_scene():
	get_tree().change_scene_to_file("res://level_select.tscn")
