class_name EnemyMoveStateMachine
extends Node

@export var CAMERA_CONTROLLER : CameraController
@export var VELOCITY_COMPONENT : VelocityComponent

var TARGET : CharacterBody3D
var current_move_state : MoveState

@onready var states := {
	"idle": $Idle,
	"run": $Run,
	"jump": $Jump,
	"attack": $Attack,
	"fall": $Fall,
	"land": $Land,
}


func _ready() -> void:
	TARGET = get_owner()
	var animation_player := $"../../Model/AnimationPlayer"
	current_move_state = states["idle"]
	for state in states.values():
		state.TARGET = TARGET
		state.VELOCITY_COMPONENT = VELOCITY_COMPONENT
		state.ANIMATION_PLAYER = animation_player

func physics_update(input: InputPackage, delta: float) -> void:
	var relevance = current_move_state.check_relevance(input)
	if relevance != "okay":
		switch_to(relevance)
	current_move_state.physics_update(input, delta)


func update(input: InputPackage, delta: float) -> void:
	current_move_state.update(input, delta)


func switch_to(new_state_name: String) -> void:
	if current_move_state != states[new_state_name]:
		current_move_state.exit()
	var previous_state : MoveState = current_move_state
	current_move_state = states[new_state_name]
	Global.debug.update_label("MoveState", current_move_state.name)
	current_move_state.enter(previous_state)
	current_move_state.mark_enter_state()
