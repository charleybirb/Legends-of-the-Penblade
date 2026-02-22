extends AttackState


func enter() -> void:
	HITBOX.monitoring = true
	apply_strength_multiplier()
	play_animation("attack3", 0.1)
