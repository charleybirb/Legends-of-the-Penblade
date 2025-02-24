extends MoveState

const GRAVITY := 9.8
const ROTATION_SPEED := 6.0
const SPEED := 3.95
const ACCELERATION := 5.0
const JUMP_BUFFER := 0.2

@export var LEDGE_RAY : RayCast3D

var time_jump_pressed : float


func check_relevance(_input: InputPackage) -> String:
	if TARGET.is_on_floor():
		return "land"
	#if LEDGE_RAY.get_collider() != null:
		#
		#return "ledge_grab"
	return "okay"


func enter(_previous_move_state: MoveState) -> void:
	VELOCITY_COMPONENT.fall()
	play_animation("fall", 0.1)
	#LEDGE_RAY.enabled = true

#func exit() -> void:
	#LEDGE_RAY.enabled = false


func physics_update(input: InputPackage, delta: float) -> void:
	if "jump" in input.actions:
		STATE_MACHINE.is_jump_queued = true
		time_jump_pressed = Time.get_unix_time_from_system()
	if STATE_MACHINE.is_jump_queued:
		if (Time.get_unix_time_from_system() - time_jump_pressed > JUMP_BUFFER) or (
		"jump" in input.released_actions):
			STATE_MACHINE.is_jump_queued = false
	if input.input_direction != Vector2.ZERO:
		VELOCITY_COMPONENT.update_rotation(ROTATION_SPEED, delta)
	VELOCITY_COMPONENT.apply_gravity(delta)
	VELOCITY_COMPONENT.update_velocity(input, SPEED, ACCELERATION, delta)
	VELOCITY_COMPONENT.apply_movement()
