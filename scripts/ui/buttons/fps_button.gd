extends SubMenuButton

func _ready() -> void:
	option_index = 1 if Engine.max_fps == 30 else 2


func set_option(is_tweened:=true) -> void:
	var new_position := Vector2(0, OPTION_MARKER.global_position.y)
	new_position.x = get_option_position()
	match option_index:
		1: 
			Engine.max_fps = 30
		2: 
			Engine.max_fps = 60
	if !is_tweened:
		OPTION_MARKER.global_position = new_position
		return
	var tween := get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(OPTION_MARKER, "global_position", new_position, 0.2)
