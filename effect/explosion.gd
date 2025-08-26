extends Area2D




func _ready() -> void:
	$AnimatedSprite2D.play("default")
	$CollisionShape2D.disabled = false
	$explodeSFX.play()


func _on_animated_sprite_2d_animation_finished() -> void:
	self.queue_free()


func _on_willhurt_timer_timeout() -> void:
	$CollisionShape2D.disabled = true
