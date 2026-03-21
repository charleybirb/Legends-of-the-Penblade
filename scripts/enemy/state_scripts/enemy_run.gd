extends EnemyMoveState
class_name EnemyMoveRun

const TURN_SPEED := 200
const MOVE_SPEED := 3
const ACCELERATION := 4
const DECELERATION := 10
const FOLLOW_DISTANCE := 1.0
const WEIGHT := 1.0

var PLAYER : Player

func enter(previous_state_name: StringName) -> void:
	if previous_state_name == &"idle":
		play_animation(&"activate")
		await ANIMATION_PLAYER.animation_finished
		play_animation(&"chase", 0.3)
	else:
		play_animation(&"chase", 0.3)


func physics_update(delta: float) -> void:
	apply_gravity()
	if ANIMATION_PLAYER.current_animation == &"activate" or ANIMATION_PLAYER == null:
		return
	var to_player := PLAYER.global_transform.origin - TARGET.global_transform.origin
	var distance := to_player.length()
	to_player = to_player.normalized()
	var acceleration := ACCELERATION * (distance - FOLLOW_DISTANCE)
	TARGET.velocity.x = lerp(TARGET.velocity.x, to_player.x * MOVE_SPEED, acceleration * delta)
	TARGET.velocity.z = lerp(TARGET.velocity.z, to_player.z * MOVE_SPEED, acceleration * delta)
	#TARGET.velocity.y = 0
	var right := TARGET.global_transform.basis.x
	var r_dot := to_player.dot(right)
	
	TARGET.rotation_degrees.y += TURN_SPEED * -r_dot * delta
