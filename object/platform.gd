extends Path2D



@export var genarator_node: PlatformGenarator

@export var speed_scale = 1

var can_move: bool = false


var last_animation_length = null


func _ready() -> void:
	$AnimationPlayer.speed_scale = speed_scale
	$AnimationPlayer.play("RESET")


func _stop_animation():
	if can_move == false:
		$AnimationPlayer.pause()


func _process(delta: float) -> void:
	if genarator_node.power > 1:
		can_move = true
	else:
		can_move = false
		
		
	if can_move:
		if not $AnimationPlayer.is_playing():
			if last_animation_length != null:
				$AnimationPlayer.seek(last_animation_length)
			else:
				$AnimationPlayer.play("progress_ratio")
			
			
