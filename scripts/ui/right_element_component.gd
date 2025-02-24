extends Node

var parent : Control

func _ready() -> void:
	parent = get_parent()
	var original_modulate = parent.modulate
	parent.modulate = Color(1,1,1,0)
	await get_tree().create_timer(0.05).timeout
	var origin_position := parent.position
	parent.position.x += parent.size.x + 100
	var tween := get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(parent, "position", origin_position, 0.3)
	tween.parallel().tween_property(parent, "modulate", original_modulate, 0.6)
