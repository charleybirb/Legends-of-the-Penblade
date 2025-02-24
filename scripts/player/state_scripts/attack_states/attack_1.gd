extends AttackState


func enter() -> void:
	COLLISION_AREA.monitoring = true
	play_animation("attack1", 0.1)
