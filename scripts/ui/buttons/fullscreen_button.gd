extends SubMenuButton

func _ready() -> void:
	option_index = 1 if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN else 2


func set_option(is_tweened:=true) -> void:
	var new_position := Vector2(0, OPTION_MARKER.global_position.y)
	new_position.x = get_option_position()
	match option_index:
		1: 
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		2: 
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			#DisplayServer.window_set_size(Vector2(960, 540))
			#DisplayServer.window_set_position(DisplayServer.screen_get_size() / 4)
	if !is_tweened:
		OPTION_MARKER.global_position = new_position
		return
	var tween := get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(OPTION_MARKER, "global_position", new_position, 0.2)
