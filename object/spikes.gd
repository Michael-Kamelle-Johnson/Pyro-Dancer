extends Actor
class_name Spikes


var canFall: bool = false


func _ready() -> void:
	$AnimationPlayer.play("RESET")

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		
		if canFall == false:
			$AnimationPlayer.play("shake")
		else:
			velocity.y -= fall_speed * delta
	else:
		canFall = false
			
			
			
	move_and_slide()


func _animation_end():
	canFall = true
