extends EnemyMoveState
class_name EnemyMoveIdle

func enter(_previous_state_name: StringName) -> void:
	play_animation(&"idle")

func physics_update(delta: float) -> void:
	TARGET.velocity = lerp(TARGET.velocity, Vector3.ZERO, 10 * delta)
	apply_gravity()
