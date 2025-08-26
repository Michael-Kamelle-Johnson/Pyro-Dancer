extends Actor
class_name playerball



const fireball = preload("res://object/playerball.tscn")
var dir = -1



var hops: int = 0

signal shrink_ball
var shrink = 0

var isGrounded: bool = false


func _ready() -> void:
	shrink_ball.connect(_on_shrink_ball)
	shrink = 0
	$AnimationPlayer.play("spin")
	$shrinkAnimationPlayer.play("RESET")
	$Debug.show()


static func new_bullet(position, direction, move_speed):
	var proj = fireball.instantiate()
	proj.position = position
	proj.dir = direction
	proj.move_speed = move_speed
	return proj
	
	
	
func _on_shrink_ball():
	if shrink == 0:
		$shrinkAnimationPlayer.play("shrink1")
	elif shrink == 1:
		$shrinkAnimationPlayer.play("shrink2")
	
	
	
func _physics_process(delta: float) -> void:
	velocity.x = move_speed * dir
	var randomHeight = randf_range(10, 90)
	
	if is_on_floor():
		
		if isGrounded == false:
			hops += 1
			isGrounded = true
			
			if hops == 4:
				velocity.y -= jump_height + 500
			
			elif hops == 5:
				shrink += 1
				shrink_ball.emit()
			
			elif hops == 6:
				shrink += 1
				shrink_ball.emit()
			
		else:
			velocity.y -= jump_height + randomHeight
			isGrounded = false
			
			if hops == 9:
				$killTimer.start()
	else:
		velocity.y -= fall_speed * delta
	
	
	if $lwalldetect.is_colliding():
		dir = 1
		
	if $rwalldetect.is_colliding():
		dir = -1
	
	
	move_and_slide()
	
	$Debug/hopLabel.text = str(hops-1)
	

func _on_kill_timer_timeout() -> void:
	self.queue_free()


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("fire") and not area.is_in_group("fireball"):
		hops = 2
		$shrinkAnimationPlayer.play("RESET_SHRINK")
		shrink = 0
		$killTimer.stop()
