extends Node
class_name EnemyMoveState

signal transition_to(new_state_name : StringName)

const GRAVITY : float = 25.0

var ANIMATION_PLAYER : AnimationPlayer
var TARGET : Enemy


func enter(_previous_state_name: StringName) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func exit() -> void:
	pass


func apply_gravity() -> void:
	if not TARGET.is_on_floor():
		transition_to.emit(&"fall")
	else:
		TARGET.velocity.y = 0


func play_animation(anim_name: StringName, blend:=-1.0, speed:=1.0) -> void:
	if ANIMATION_PLAYER.current_animation == anim_name: return
	ANIMATION_PLAYER.pause()
	ANIMATION_PLAYER.play(anim_name, blend, speed)
	#print("playing ", anim_name)
