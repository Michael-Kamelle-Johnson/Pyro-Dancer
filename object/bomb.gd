extends RigidBody2D



@onready var explosion = preload("res://effect/explosion.tscn")

@onready var anim_player = $AnimationPlayer
@onready var squash_anim_player = $squashAnimationPlayer

enum states {idle, ticking}
var current_state = states.idle


var tick = 3

var Ticker_not_on = true


signal bomb_timeout

func _ready() -> void:
	squash_anim_player.play("default")
	bomb_timeout.connect(_on_explosion)
	$bomb/spark.hide()
	tick = 3
	#current_state = states.ticking

func _on_explosion():
	_do_explosion()

func _do_explosion():
	var effect = explosion.instantiate()
	$bomb.hide()
	#$CollisionShape2D.disabled = true
	$bomb/spark.hide()
	effect.position = global_position
	get_parent().add_child(effect)
	Globals.camera_shake.emit()
	$killTimer.start()




func _game_states():
	match current_state:
		states.idle:
			pass
		states.ticking:
			if Ticker_not_on:
				$tickTimer.start()
				Ticker_not_on = false
			
			$bomb/spark.show()
			if tick >= 3:
				anim_player.play("ticking")
			elif tick == 2:
				anim_player.play("ticking_2")
			elif tick == 1:
				anim_player.play("ticking_3")
			elif tick == 0:
				bomb_timeout.emit()
				set_physics_process(false)
				
			


func _physics_process(delta: float) -> void:
	_game_states()



func _on_tick_timer_timeout() -> void:
	tick -= 1
	
	if current_state == states.ticking:
		$tickTimer.start()


func _on_kill_timer_timeout() -> void:
	self.queue_free()


func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("fire"):
		current_state = states.ticking
		$hurtbox/CollisionShape2D.disabled = true



func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("fire"):
		current_state = states.ticking
		$hurtbox/CollisionShape2D.disabled = true
