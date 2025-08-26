extends Switch




@export_enum("standard", "forever_on") var button_type = "standard"

@export var no_fire: bool = false

@onready var sprite = $Sprite2D


var button_pressed: bool = false

func _ready() -> void:
	button_pressed = false


func _on_body_entered(body: Node2D) -> void:
	
	if button_pressed == false:
		if no_fire == true:
			if body is Player:
				sprite.frame = 1
				trigger.emit()
		else:
			sprite.frame = 1
			trigger.emit()
			button_pressed = true
			
		
	
	#if button_pressed == false:
		#if no_fire == true:
			#if body is Player:
				#sprite.frame = 1
				#trigger.emit()
		#else:
			#sprite.frame = 1
			#trigger.emit()
		
		


func _on_body_exited(body: Node2D) -> void:
	if button_type == "forever_on":
		return
	
	if no_fire == true:
		if not body is playerball:
			sprite.frame = 0
			detrigger.emit()
	else:
		sprite.frame = 0
		detrigger.emit()
		
	button_pressed = false
