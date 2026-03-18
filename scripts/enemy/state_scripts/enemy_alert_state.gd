extends Node
class_name EnemyAlertState

var ANIMATION_PLAYER : AnimationPlayer

func enter() -> void:
	pass

func exit() -> void:
	pass


func play_animation(anim_name: StringName, custom_blend : float = -1.0) -> void:
	if ANIMATION_PLAYER:
		ANIMATION_PLAYER.play(anim_name, custom_blend)
