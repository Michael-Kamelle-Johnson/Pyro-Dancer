extends StaticBody2D
class_name PlatformGenarator



var power: int = 0
var max_power: int = 100



var isTouching: bool = false


func _ready() -> void:
	$TextureProgressBar.max_value = max_power

func _process(delta: float) -> void:
	$powerLabel.text = "Power: " + str(power)
	$TextureProgressBar.value = power


func _physics_process(delta: float) -> void:
	
	if isTouching:
		var areas = $TriggerArea.get_overlapping_areas()
		
		for area in areas:
			if area.is_in_group("fire"):
				power = lerp(power, max_power, 0.09)
				
	else:
		power = lerp(power, 0, 0.000001)
	
	





func _on_trigger_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("fire"):
		isTouching = true


func _on_trigger_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("fire"):
		isTouching = false
