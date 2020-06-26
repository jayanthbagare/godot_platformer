extends Actor

export var stomp_impulse: = 1000.0

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity,stomp_impulse)


func _on_EnemyDetector_body_entered(body: Node) -> void:
	queue_free()


func _physics_process(delta: float) -> void:
	var is_jump_interrupted: bool = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: Vector2 = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	var snap: Vector2 = Vector2.DOWN * 60.0 if direction.y == 0.0 else Vector2.ZERO
	_velocity = move_and_slide_with_snap(
		_velocity, snap, FLOOR_NORMAL, true
	)
	
func get_direction():
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
	   -1 if is_on_floor() and Input.is_action_just_pressed("jump") else 1.0
	)
	
func calculate_move_velocity(	
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2,
	is_jump_interrupted: bool
) -> Vector2:
	var velocity: = linear_velocity
	velocity.x = speed.x * direction.x
	if direction.y == -1.0:
		velocity.y = speed.y * direction.y
	
	if is_jump_interrupted:
		velocity.y = 0.0
		
	return velocity

func calculate_stomp_velocity(
	linear_velocity: Vector2,
	impulse: float
) -> Vector2:
	var out: = linear_velocity
	out.y = - impulse
	return out

