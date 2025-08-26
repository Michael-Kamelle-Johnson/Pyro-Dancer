extends CanvasLayer






func _ready() -> void:
	Globals.reset_scene.connect(_on_reset_scene)
	Globals.player_death.connect(_on_player_death)
	$Label.hide()
	
	
	
func _on_player_death():
	$Label.show()


func _on_reset_scene():
	$Label.hide()
