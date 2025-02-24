class_name RunMoveState
extends MoveState

const RUN_SPEED := 5.2
const WALK_SPEED := 2.8
const ACCELERATION := 4.5
const ROTATION_SPEED := 8.0

var speed := RUN_SPEED

func check_relevance(input: InputPackage) -> String:
	input.actions.sort_custom(move_state_priority_sort)
	if !TARGET.is_on_floor():
		if check_fall_distance():
			return "fall"
		return "okay"
	else:
		if FALL_RAY.enabled: FALL_RAY.enabled = false
		if input.actions[0] != "run" and input.actions[0] != "walk":
			return input.actions[0]
		return "okay"


func enter(_previous_move_state: MoveState) -> void:
	play_animation("run", 0.3, 1.6)
	speed = RUN_SPEED


func physics_update(input: InputPackage, delta: float) -> void:
	if "walk" in input.action_modifiers and speed == RUN_SPEED:
		speed = WALK_SPEED
		play_animation("walk", 0.3, 1.6)
	elif "walk" in input.released_action_modifiers:
		play_animation("run", 0.3, 1.6)
		speed = RUN_SPEED
	VELOCITY_COMPONENT.update_velocity(input, speed, ACCELERATION, delta)
	VELOCITY_COMPONENT.update_rotation(ROTATION_SPEED, delta)
	if !TARGET.is_on_floor(): VELOCITY_COMPONENT.apply_gravity(delta)
	VELOCITY_COMPONENT.apply_movement()
