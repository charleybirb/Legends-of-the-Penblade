extends AttackState

func enter() -> void:
	COLLISION_AREA.monitoring = true
	play_animation("attack3", 0.1)
