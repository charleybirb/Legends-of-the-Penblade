extends MoveState

const DECELERATION = 15.0

var is_interacting := false
var queued_action : String

func _on_animation_finished(_animation: String) -> void:
	is_interacting = false
	ANIMATION_PLAYER.disconnect(&"animation_finished", _on_animation_finished)


func check_relevance(input: InputPackage) -> StringName:
	if !is_interacting:
		if queued_action:
			return queued_action
		else:
			input.actions.sort_custom(move_state_priority_sort)
			return input.actions[0]
	else:
		return &"okay"


func enter(_previous_move_state: MoveState) -> void:
	queued_action = &""
	is_interacting = true
	play_animation(&"interact", 0.3, 1.0)
	ANIMATION_PLAYER.connect(&"animation_finished", _on_animation_finished)
	await get_tree().create_timer(0.4).timeout
	queued_action = &""


func update(input: InputPackage, _delta: float) -> void:
	input.actions.sort_custom(move_state_priority_sort)
	if input.actions[0] != &"idle":
		queued_action = input.actions[0]


func physics_update(_input: InputPackage, delta: float) -> void:
	VELOCITY_COMPONENT.kill_velocity(DECELERATION, delta)
	VELOCITY_COMPONENT.apply_gravity(delta)
	VELOCITY_COMPONENT.apply_movement()


func exit() -> void:
	queued_action = &""
