extends StaticBody2D



enum block_type {on, off}
@export var current_type: block_type


@export var trigger_node: Switch

var is_on: bool = false

func _ready() -> void:
	if trigger_node != null:
		trigger_node.trigger.connect(_on_trigger)
		trigger_node.detrigger.connect(_on_detrigger)
		
	
	
	
func _check_type():
	match current_type:
		block_type.on:
			if is_on:
				$AnimationPlayer.play("off")
			else:
				$AnimationPlayer.play("on")
		block_type.off:
			if is_on:
				$AnimationPlayer.play("on")
			else:
				$AnimationPlayer.play("off")
	
	
	
func _process(delta: float) -> void:
	_check_type()
	
	
func _on_trigger():
	is_on = true
	

func _on_detrigger():
	is_on = false
