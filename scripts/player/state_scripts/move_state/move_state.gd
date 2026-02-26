class_name MoveState
extends Node

@export var CAMERA : Camera3D
@export var STATE_MACHINE : PlayerMoveStateMachine
@export var FALL_RAY : RayCast3D

var VELOCITY_COMPONENT : VelocityComponent
var ANIMATION_PLAYER : AnimationPlayer
var PLAYER : Player

var enter_state_time : float

#higher numbers are sorted as higher priority when multiple states are being compared
static var move_state_priority : Dictionary = {
	"idle": 1,
	"run": 2,
	"ledge_grab": 3,
	"secondary_action": 4,
	"primary_action": 5,
	"knockback": 6,
	"stun": 7,
	"jump": 8,
	"fall": 9,
	"land": 10,
}


static func move_state_priority_sort(a: StringName, b: StringName) -> bool:
	if move_state_priority[a] > move_state_priority[b]:
		return true
	else:
		return false


func mark_enter_state() -> void:
	enter_state_time = Time.get_unix_time_from_system()


func get_progress() -> float:
	var now : float = Time.get_unix_time_from_system()
	return now - enter_state_time


func works_longer_than(time: float) -> bool:
	if get_progress() >= time:
		return true
	return false


func works_less_than(time: float) -> bool:
	if get_progress() < time:
		return true
	return false


func works_during(start_time: float, finish_time: float) -> bool:
	var progress := get_progress()
	if progress >= start_time and progress <= finish_time:
		return true
	return false


func enter(_previous_move_state: MoveState) -> void:
	pass

func update(_input: InputPackage, _delta: float) -> void:
	pass

func physics_update(_input: InputPackage, _delta: float) -> void:
	pass

func check_relevance(_input: InputPackage) -> StringName:
	push_warning("implement the check_relevance function on move state")
	return "error, implement the check_relevance function on move state"


func exit() -> void:
	pass


func play_animation(animation: String, blend:=-1.0, speed:=1.0) -> void:
	if ANIMATION_PLAYER.current_animation == animation: return
	#ANIMATION_PLAYER.pause()
	ANIMATION_PLAYER.play(animation, blend, speed)


func check_fall_distance() -> bool:
	if !FALL_RAY.enabled: FALL_RAY.enabled = true
	var is_falling := false
	if !FALL_RAY.get_collider():
		is_falling = true
	return is_falling
