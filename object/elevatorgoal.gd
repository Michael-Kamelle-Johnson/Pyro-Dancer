extends Area2D
class_name Goalie



@export var goal_genarator: GoalieGenarator


var canOpen: bool = false
var isNotOpen: bool = true

var isTouching: bool = false


func _ready() -> void:
	goal_genarator.activated.connect(_on_activated)
	$AnimatedSprite2D.play_backwards("default")
	
	
	
func _on_activated():
	if canOpen == false:
		$AnimatedSprite2D.play("default")
		$DingSFX.play()
		canOpen = true


func _process(delta: float) -> void:
	#fix this here
	if canOpen == true and isNotOpen == false:
		if isTouching == true:
			if Input.is_action_just_pressed("intreract_key"):
				print("end")
				Globals.level_finished.emit()


func _on_body_entered(body: Node2D) -> void:
	if isNotOpen and canOpen:
		$OpeningSFX.play()
		$AnimatedSprite2D.play("open")
		isNotOpen = false
		isTouching = true


func _on_body_exited(body: Node2D) -> void:
	if isNotOpen == false and canOpen:
		$ClosingSFX.play()
		$AnimatedSprite2D.play_backwards("open")
		isNotOpen = true
		isTouching = false
