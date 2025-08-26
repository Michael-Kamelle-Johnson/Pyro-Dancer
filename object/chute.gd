extends StaticBody2D




@export var trigger_node: Switch
@export var object_to_spawn: PackedScene

var canSpawn: bool = true

func _ready() -> void:
	if trigger_node != null:
		trigger_node.trigger.connect(_on_spawn_object)


func _on_spawn_object():
	if object_to_spawn != null and canSpawn:
		var obj = object_to_spawn.instantiate()
		obj.position = $objectplacement.global_position
		get_parent().add_child(obj)
		canSpawn = false
		$cooldownTimer.start()


func _on_cooldown_timer_timeout() -> void:
	canSpawn = true
