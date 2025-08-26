extends StaticBody2D




var destroy_effect = preload("res://effect/brickdestroyed.tscn")



func _destroy_effects():
	var effects = destroy_effect.instantiate()
	
	effects.position = global_position
	effects.one_shot = true
	effects.emitting = true
	
	get_parent().add_child(effects)



func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("bomb_explosion"):
		_destroy_effects()
		self.queue_free()
