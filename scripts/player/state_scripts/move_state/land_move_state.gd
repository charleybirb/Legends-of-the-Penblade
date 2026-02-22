class_name LandMoveState
extends MoveState

const DECELERATION := 35.0
const MIN_LAND_TIME := 0.2

var is_landed = false

func check_relevance(input: InputPackage) -> StringName:
	if works_longer_than(MIN_LAND_TIME):
		if STATE_MACHINE.is_jump_queued:
			STATE_MACHINE.is_jump_queued = false
			return &"jump"
		else:
			input.actions.sort_custom(move_state_priority_sort)
			return input.actions[0]
	else:
		return &"okay"


func enter(_previous_move_state: MoveState) -> void:
	if VELOCITY_COMPONENT.velocity.y == VELOCITY_COMPONENT.MAX_FALL_VELOCITY:
		play_animation(&"land")
	else:
		play_animation(&"land", -1, 1.3)
	VELOCITY_COMPONENT.velocity.y = 0


func physics_update(input: InputPackage, delta: float) -> void:
	if &"jump" in input.actions:
		STATE_MACHINE.is_jump_queued = true
	if &"jump" in input.released_actions:
		STATE_MACHINE.is_jump_queued = false
	VELOCITY_COMPONENT.kill_velocity(DECELERATION, delta)
	VELOCITY_COMPONENT.apply_gravity(delta)
	VELOCITY_COMPONENT.apply_movement()
