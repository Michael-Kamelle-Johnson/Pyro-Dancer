extends StaticBody2D
class_name GoalieGenarator


signal activated


func _on_trigger_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("fire"):
		activated.emit()
		$AnimatedSprite2D.play("chargeup")
		$chargeUPSFX.play()


func _on_trigger_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("fire"):
		activated.emit()
		$AnimatedSprite2D.play("chargeup")
		#$chargeUPSFX.play()
