class_name PlayerMoveStateMachine
extends Node

@export var CAMERA_CONTROLLER : CameraController
@export var VELOCITY_COMPONENT : VelocityComponent
@export var ANIMATION_PLAYER : AnimationPlayer
var PLAYER : Player
var current_move_state : MoveState
var is_jump_queued := false
var previous_move_state : MoveState

@onready var STATES := {
	"idle": $Idle,
	"run": $Run,
	"jump": $Jump,
	"fall": $Fall,
	"land": $Land,
	"ledge_grab": $LedgeGrab,
	"primary_action": $PrimaryAction,
	"secondary_action": $SecondaryAction,
}


func _ready() -> void:
	PLAYER = get_owner()
	current_move_state = STATES["idle"]
	for state : MoveState in STATES.values():
		state.PLAYER = PLAYER
		state.VELOCITY_COMPONENT = VELOCITY_COMPONENT
		state.ANIMATION_PLAYER = ANIMATION_PLAYER


func physics_update(input: InputPackage, delta: float) -> void:
	var relevance : StringName = current_move_state.check_relevance(input)
	if relevance != &"okay":
		switch_to(relevance)
	current_move_state.physics_update(input, delta)


func update(input: InputPackage, delta: float) -> void:
	current_move_state.update(input, delta)


func switch_to(state: String) -> void:
	if current_move_state != STATES[state]:
		current_move_state.exit()
	previous_move_state = current_move_state
	current_move_state = STATES[state]
	SignalBus.debug_updated.emit("MoveState", current_move_state.name)
	current_move_state.enter(previous_move_state)
	current_move_state.mark_enter_state()
