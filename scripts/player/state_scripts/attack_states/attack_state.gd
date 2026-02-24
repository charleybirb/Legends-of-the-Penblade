class_name AttackState
extends Node

const BASE_STRENGTH : int = 1

@export var HITBOX : Area3D
@export var STRENGTH_MULTIPLIER : float = 1.0
@export var KNOCKBACK_STRENGTH : float = 10.0
@export var ANIM_NAME : StringName

var SFX_MANAGER : SFXManager
var ANIMATION_PLAYER : AnimationPlayer
var PLAYER : Player

var targets_hit : Array[Node3D]


func enter() -> void:
	HITBOX.set_collision_layer_value(4, true)
	apply_strength_multiplier()
	play_animation(ANIM_NAME, 0.1)
	SFX_MANAGER.get_sound(&"attack")


func exit() -> void:
	Global.debug.remove_label("EnemyAttacked")
	HITBOX.set_collision_layer_value(4, false)
	targets_hit.clear()


func apply_strength_multiplier() -> void:
	PLAYER.full_strength = PLAYER.base_strength * STRENGTH_MULTIPLIER


func play_animation(animation: String, blend:=-1.0, speed:=1.0) -> void:
	if ANIMATION_PLAYER.current_animation == animation: return
	ANIMATION_PLAYER.play(animation, blend, speed)
