class_name EnemyMoveStateMachine
extends Node

@export var VELOCITY_COMPONENT : VelocityComponent
@export var ANIMATION_PLAYER : AnimationPlayer

var TARGET : Enemy
var current_move_state : EnemyMoveState

@onready var states : Dictionary[StringName, EnemyMoveState] = {
	&"idle": $Idle,
	&"run": $Run,
	#&"jump": $Jump,
	#&"attack": $Attack,
	#&"fall": $Fall,
	#&"land": $Land,
}


func _on_player_detected(player: Player) -> void:
	states[&"run"].PLAYER = player
	switch_to(&"run")


func _ready() -> void:
	#await owner.ready
	TARGET = get_owner()
	current_move_state = states[&"idle"]
	for state : EnemyMoveState in states.values():
		state.TARGET = TARGET
		#state.VELOCITY_COMPONENT = VELOCITY_COMPONENT
		state.ANIMATION_PLAYER = ANIMATION_PLAYER
	current_move_state.enter(null)


func physics_update(delta: float) -> void:
	current_move_state.physics_update(delta)


func update(delta: float) -> void:
	current_move_state.update(delta)


func switch_to(new_state_name: StringName) -> void:
	if current_move_state != states[new_state_name]:
		current_move_state.exit()
	var previous_state : EnemyMoveState = current_move_state
	current_move_state = states[new_state_name]
	SignalBus.debug_updated.emit("MoveState", current_move_state.name)
	current_move_state.enter(previous_state)
	#current_move_state.mark_enter_state()
