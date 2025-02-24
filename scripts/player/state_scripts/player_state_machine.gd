class_name PlayerStateMachine
extends Node

@export var MOVE_STATE_MACHINE : PlayerMoveStateMachine
@export var ATTACK_STATE_MACHINE : PlayerAttackStateMachine
@export var ANIMATION_PLAYER : AnimationPlayer

var current_move_state : String
var current_attack_state : String
