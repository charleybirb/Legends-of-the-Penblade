extends EnemyMoveState

func enter(_previous_state_name: StringName) -> void:
	#TARGET.velocity = Vector3.ZERO
	play_animation(&"smack")
	await ANIMATION_PLAYER.animation_finished
	transition_to.emit(&"run")
