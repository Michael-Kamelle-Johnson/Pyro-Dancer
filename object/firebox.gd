extends StaticBody2D
class_name Firebox


enum firebox_type {standard, switch}
@export var BoxType: firebox_type

@export var trigger_node: Switch

@export var cooldown_time: float = 3

var canLit: bool = true


func _ready() -> void:
	if BoxType == firebox_type.standard:
		$cooldownTimer.start(cooldown_time)
	
	if BoxType == firebox_type.switch:
		if trigger_node != null:
			trigger_node.trigger.connect(_on_trigger)
			trigger_node.detrigger.connect(_on_detrigger)


func _on_trigger():
	if canLit:
		$AnimationPlayer.play("play_fire")
		canLit = false

func _on_detrigger():
	pass

func _animation_end():
	if BoxType == firebox_type.standard:
		$cooldownTimer.start(cooldown_time)
	
	if BoxType == firebox_type.switch:
		canLit = true


func _on_cooldown_timer_timeout() -> void:
	$AnimationPlayer.play("play_fire")
