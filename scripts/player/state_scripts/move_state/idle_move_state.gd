extends MoveState

const DECELERATION := 45.0
const ROTATION_SPEED := 6.0
const ROTATION_BUFFER := 0.5

var idle_start_time : float
var is_rotated := false


func check_relevance(input: InputPackage) -> String:
	if not TARGET.is_on_floor():
		if check_fall_distance():
			return "fall"
		return "okay"
	if not "idle" in input.actions:
		input.actions.sort_custom(move_state_priority_sort)
		return input.actions[0]
	return "okay"


func enter(previous_move_state: MoveState) -> void:
	play_animation("idle", 0.3)
	if previous_move_state is RunMoveState: is_rotated = false


func physics_update(_input: InputPackage, delta: float) -> void:
	if !TARGET.is_on_floor(): VELOCITY_COMPONENT.apply_gravity(delta)
	VELOCITY_COMPONENT.kill_velocity(DECELERATION, delta)
	VELOCITY_COMPONENT.apply_movement()
	if !is_rotated:
		if works_less_than(ROTATION_BUFFER):
			VELOCITY_COMPONENT.update_rotation(ROTATION_SPEED, delta, true)
		else:
			is_rotated = true


func exit() -> void:
	is_rotated = true
