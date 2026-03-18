extends EnemyMoveState
class_name EnemyMoveIdle

func enter(_previous_state: EnemyMoveState) -> void:
	play_animation(&"idle")

func physics_update(delta: float) -> void:
	apply_gravity(delta)
