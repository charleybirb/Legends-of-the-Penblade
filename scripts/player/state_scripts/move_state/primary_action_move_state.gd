extends MoveState

const DECELERATION := 20.0
const QUEUE_BUFFER_TIME := 0.3

@export var ATTACK_STATE_MACHINE : PlayerAttackStateMachine

var is_action_queued := false
var is_action_ongoing := false
var is_action_cancelled := false
var action_start_time := 0.0
var queue_start_time := 0.0
var max_queue_time := 0.6


func check_relevance(input: InputPackage) -> StringName:
	if is_action_cancelled:
		is_action_cancelled = false
		return &"idle"
	if !is_action_ongoing:
		if !is_action_queued:
			input.actions.sort_custom(move_state_priority_sort)
			return input.actions[0]
		else:
			is_action_queued = false
			return &"primary_action"
	else:
		return &"okay"


func _ready() -> void:
	SignalBus.primary_action_committed.connect(commit_action)
	SignalBus.primary_action_blocked.connect(cancel_action)


func enter(_previous_move_state: MoveState) -> void:
	SignalBus.primary_action_attempted.emit()


func cancel_action() -> void:
	is_action_cancelled = true


func commit_action(action_name: StringName) -> void:
	action_start_time = curr_time()
	is_action_ongoing = true
	if action_name.begins_with("attack"):
		ATTACK_STATE_MACHINE.start_attack()
		max_queue_time = ANIMATION_PLAYER.current_animation_length
		


func update(input: InputPackage, _delta: float) -> void:
	if &"primary_action" in input.actions and get_action_time() >= QUEUE_BUFFER_TIME:
		is_action_queued = true
		queue_start_time = curr_time()
	if is_action_queued and get_queue_time() >= max_queue_time:
		is_action_queued = false


func physics_update(_input: InputPackage, delta: float) -> void:
	VELOCITY_COMPONENT.kill_velocity(DECELERATION, delta)
	VELOCITY_COMPONENT.apply_movement()


func exit() -> void:
	is_action_ongoing = false
	ATTACK_STATE_MACHINE.attack_index = 0


func curr_time() -> float:
	return Time.get_unix_time_from_system()


func get_action_time() -> float:
	return curr_time() - action_start_time


func get_queue_time() -> float:
	return queue_start_time - action_start_time
