extends CanvasLayer





func _ready() -> void:
	$AnimationPlayer.play("RESET")
	
	Globals.screen_transition.connect(_on_animation)
	
func _on_animation():
	$AnimationPlayer.play("fade_in")


func _animation_ended():
	Globals.next_scene.emit()
