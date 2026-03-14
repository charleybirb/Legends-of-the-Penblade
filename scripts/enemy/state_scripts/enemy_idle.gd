extends EnemyMoveState

func enter(_previous_state: EnemyMoveState) -> void:
	play_animation(&"idle")
