extends Actor
class_name Player


@onready var death_particles = preload("res://effect/playerexplosion.tscn")

@onready var anim_tree = $AnimationTree.get("parameters/playback")

@onready var coyoteTimer = $coyoteTimer


var axis: Vector2


var knockback_strength = 300
var knockback_speed = 100.0


#enum states {idle, move, air, damaged}
var game_states = {
	"idle" : 0,
	"move" : 1,
	"air" : 2,
	"damaged" : 3,
	"shoot" : 4
}


var current_state = game_states["air"]
var user_input: bool = true

var direction = 1


var push_strength = 2.0


var isDead: bool = false

var canJump: bool = true


func _ready() -> void:
	$AnimationTree.active = true
	isDead = false


func _get_axis():
	axis.x = Input.get_axis("left_key", "right_key")
	axis.y = Input.get_axis("down_key", "up_key")
	return axis


func _sprite_flip():
	if _get_axis().x == 1:
		$Player.flip_h = false
		direction = 1
	elif _get_axis().x == -1:
		$Player.flip_h = true
		direction = -1


func _set_state(state: String):
	if state != null:
		if game_states.has(state):
			current_state = game_states[state]
		else:
			print("no such state exist!")

func _do_fireball():
	$FireballSFX.play()
	get_parent().add_child(playerball.new_bullet($fireposition.global_position, direction, move_speed))

func _knockback():
	velocity.x = knockback_strength * (direction * -1)


func _spawn_death_effets():
	var effects = death_particles.instantiate()
	
	effects.position = global_position
	effects.one_shot = true
	effects.emitting = true
	
	get_parent().add_child(effects)

func _on_death():
	_spawn_death_effets()
	$DeathSFX.play()
	Globals.player_death.emit()
	Globals.camera_shake.emit()
	self.hide()
	$CollisionShape2D.disabled = true
	set_physics_process(false)
	isDead = true



func _idle_state():
	anim_tree.travel("idle")
	velocity.x = 0
	
	if not _get_axis().x == 0:
		_set_state("move")
		
	if _get_axis().y == 1 and is_on_floor():
		anim_tree.travel("jump")
		velocity.y -= jump_height
		$JumpSFX.play()
		canJump = false
		
	
	if Input.is_action_just_pressed("action_key"):
		_set_state("shoot")
	
	if not is_on_floor():
		$coyoteTimer.start()
		anim_tree.travel("jump")
		_set_state("air")
		

func _move_state():
	anim_tree.travel("move")
	velocity.x = move_speed * axis.x
	
	if _get_axis().x == 0:
		_set_state("idle")
		
	if _get_axis().y == 1 and is_on_floor():
		anim_tree.travel("jump")
		velocity.y -= jump_height
		$JumpSFX.play()
		canJump = false
		
	if not is_on_floor():
		$coyoteTimer.start()
		anim_tree.travel("jump")
		_set_state("air")

func _air_state(delta):
	velocity.y -= fall_speed * delta
	
		
	if _get_axis().y == 1 and (canJump and not coyoteTimer.is_stopped()):
		velocity.y = 0
		anim_tree.travel("jump")
		velocity.y -= jump_height
		$JumpSFX.play()
		canJump = false

		
	velocity.x = move_speed * _get_axis().x
	
	
	if Input.is_action_just_pressed("action_key"):
		_set_state("shoot")
	
	if is_on_floor():
		_set_state("idle")
		canJump = true

func _damaged_state():
	user_input = false
	velocity.x = move_toward(velocity.x, 0, knockback_speed)
	modulate = Color(1, 1, 1, 0.5)
	$hurtbox/CollisionShape2D.disabled = true
	
	if velocity.x == 0:
		user_input = true
		modulate = Color(1, 1, 1, 1)
		$hurtbox/CollisionShape2D.disabled = false
		_set_state("idle")


func _shoot_state():
	var isShooting: bool = true
	velocity = Vector2.ZERO
	
	if isShooting:
		anim_tree.travel("shoot")
		isShooting = false

func _shoot_anim_end():
	_set_state("idle")

func _game_states(delta):
	match current_state:
		0:
			_idle_state()
		1:
			_move_state()
		2:
			_air_state(delta)
		3:
			_damaged_state()
		4:
			_shoot_state()


func _physics_process(delta: float) -> void:
	if user_input:
		_sprite_flip()
		_get_axis()
		
		
		
	_game_states(delta)
	move_and_slide()
	

	
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_strength)





func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_damager"):
		_knockback()
		_set_state("damaged")
		
	if area.is_in_group("bomb_explosion") or area.is_in_group("death"):
		_on_death()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if isDead == false:
		_on_death()
