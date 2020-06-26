extends KinematicBody2D
class_name Actor

const FLOOR_NORMAL: = Vector2.UP

export var gravity: = 3500.0
export var speed: = Vector2(300,1400)

var _velocity = Vector2.ZERO

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta

