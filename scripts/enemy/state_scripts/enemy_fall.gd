extends EnemyMoveState
class_name EnemyFall

@export var fall_timer : Timer

var prev_state_name : StringName = &""
var is_falling : bool = false


func _on_timer_timeout() -> void:
	is_falling = true


func _ready() -> void:
	fall_timer.connect(&"timeout", _on_timer_timeout)


func enter(previous_state_name: StringName) -> void:
	prev_state_name = previous_state_name
	fall_timer.start()
	

func physics_update(delta: float) -> void:
	if not TARGET.is_on_floor():
		TARGET.velocity.y += -GRAVITY * delta
		return
	if is_falling:
		transition_to.emit(&"idle")
	else:
		fall_timer.stop()
		transition_to.emit(prev_state_name)


func exit() -> void:
	is_falling = false
