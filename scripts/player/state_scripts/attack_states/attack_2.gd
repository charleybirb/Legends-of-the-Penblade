extends AttackState

func enter() -> void:
	COLLISION_AREA.monitoring = true
	play_animation("attack2", 0.1)
