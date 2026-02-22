class_name AttackState
extends Node

const BASE_STRENGTH : int = 1

@export var HITBOX : Area3D
@export var STRENGTH_MULTIPLIER : float = 1.0
@export var KNOCKBACK_STRENGTH : float = 10.0
@export var ANIM_NAME : StringName

var ANIMATION_PLAYER : AnimationPlayer
var PLAYER : Player

var targets_hit : Array[Node3D]

#func _on_area_entered(area: Area3D) -> void:
	#if area.is_in_group("hitboxes"):
		#var target : Node3D = area.get_parent()
		#if not target in targets_hit:
			#attack(target)

#
#func _ready() -> void:
	#HITBOX.connect("area_entered", _on_area_entered)
			


func enter() -> void:
	HITBOX.set_collision_layer_value(4, true)
	apply_strength_multiplier()
	play_animation(ANIM_NAME, 0.1)


func exit() -> void:
	Global.debug.remove_label("EnemyAttacked")
	HITBOX.set_collision_layer_value(4, false)
	targets_hit.clear()


func apply_strength_multiplier() -> void:
	PLAYER.full_strength = PLAYER.base_strength * STRENGTH_MULTIPLIER

#
#func attack(target: Node3D) -> void:
	#targets_hit.append(target)
	#target.take_damage(round(BASE_STRENGTH * STRENGTH_MULTIPLIER))
	#target.knockback(KNOCKBACK_STRENGTH, PLAYER.direction)
	#Global.debug.update_label("EnemyAttacked", str(targets_hit))
	#

func play_animation(animation: String, blend:=-1.0, speed:=1.0) -> void:
	if ANIMATION_PLAYER.current_animation == animation: return
	ANIMATION_PLAYER.play(animation, blend, speed)
