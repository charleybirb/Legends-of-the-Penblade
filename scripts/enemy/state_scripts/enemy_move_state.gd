extends Node
class_name EnemyMoveState

var ANIMATION_PLAYER : AnimationPlayer
var TARGET : Enemy


func enter(_previous_move_state: EnemyMoveState) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func exit() -> void:
	pass


func play_animation(anim_name: StringName, blend:=-1.0, speed:=1.0) -> void:
	if ANIMATION_PLAYER.current_animation == anim_name: return
	#ANIMATION_PLAYER.pause()
	ANIMATION_PLAYER.play(anim_name, blend, speed)
	print("playing ", anim_name)
