extends CanvasLayer






func _ready() -> void:
	AudioController.select_music(10)


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://level_select.tscn")
