extends MoveState

const JUMP_HEIGHT := 1.65
const APEX_DURATION := 0.44 #time it takes to reach the height of the jump
const SPEED := 4.2
const ACCELERATION := 7.0
const ROTATION_SPEED := 4.0
const HOLD_TIME := 0.1

var time_apex_reached : float
var can_fall := false
var is_apex_reached := false

func check_relevance(_input: InputPackage) -> String:
	if can_fall:
		return "fall"
	if TARGET.is_on_floor():
		return "land"
	return "okay"


func enter(_previous_move_state: MoveState) -> void:
	VELOCITY_COMPONENT.jump(JUMP_HEIGHT, APEX_DURATION)
	play_animation("jump", -1)


func exit() -> void:
	is_apex_reached = false
	time_apex_reached = 0.0
	can_fall = false


func physics_update(input: InputPackage, delta: float) -> void:
	if "jump" in input.released_actions:
		can_fall = true
	var curr_time : float = Time.get_unix_time_from_system()
	if is_apex_reached:
		if (curr_time - time_apex_reached) > HOLD_TIME:
			can_fall = true
	
	if VELOCITY_COMPONENT.velocity.y > 0:
		VELOCITY_COMPONENT.apply_gravity(delta, 2.1)
	else:
		if !is_apex_reached:
			time_apex_reached = curr_time
		is_apex_reached = true
	var speed = SPEED if !is_apex_reached else SPEED / 2
	if input.input_direction != Vector2.ZERO:
		VELOCITY_COMPONENT.update_rotation(ROTATION_SPEED, delta)
	VELOCITY_COMPONENT.update_velocity(input, speed, ACCELERATION, delta)
	VELOCITY_COMPONENT.apply_movement()
