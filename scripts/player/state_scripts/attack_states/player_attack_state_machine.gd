class_name PlayerAttackStateMachine
extends Node

const DECELERATION := 10.0

@export var PLAYER : Player
@export var ANIMATION_PLAYER : AnimationPlayer
@export var WEAPON_SPOT : BoneAttachment3D
@export var SFX_MANAGER : SFXManager

var attack_index := 0
var current_attack_state : AttackState
var is_attacking := false

@onready var ATTACK_STATES := [
	$GroundAttack/Attack1,
	$GroundAttack/Attack2,
	$GroundAttack/Attack3,
]


func _on_animation_finished(animation: String) -> void:
	if not animation.begins_with("attack"): return
	end_attack()
	is_attacking = false
	ANIMATION_PLAYER.disconnect(&"animation_finished", _on_animation_finished)
	get_parent().is_action_ongoing = false


func _ready() -> void:
	await owner.ready
	for attack : AttackState in ATTACK_STATES:
		attack.PLAYER = PLAYER
		attack.ANIMATION_PLAYER = ANIMATION_PLAYER
		attack.SFX_MANAGER = SFX_MANAGER


func start_attack() -> void:
	ANIMATION_PLAYER.connect(&"animation_finished", _on_animation_finished)
	is_attacking = true
	if current_attack_state: current_attack_state.exit()
	attack_index += 1
	if attack_index > ATTACK_STATES.size():
		attack_index = 1
	Global.debug.update_label("AttackState", "Attack" + str(attack_index))
	current_attack_state = ATTACK_STATES[attack_index-1]
	current_attack_state.enter()


func end_attack() -> void:
	Global.debug.remove_label("AttackState")
	current_attack_state.exit()
