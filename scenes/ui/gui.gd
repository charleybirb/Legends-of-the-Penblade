extends CanvasLayer

const PAUSE_MENU_SCENE := preload("res://scenes/ui/pause_menu.tscn")

@export var PORTRAIT : NinePatchRect

var pause_menu : PauseMenu = null


func _input(event: InputEvent) -> void:
	if event.is_action("pause") and event.pressed:
		if !get_tree().paused:
			pause_game()
		else:
			unpause_game()
	if event.is_action("test") and event.pressed:
		set_portrait("hurt")
		await get_tree().create_timer(0.5).timeout
		set_portrait("okay")

func set_portrait(expression: String) -> void:
		match expression:
			"okay": PORTRAIT.region_rect.position.x = 0
			"hurt": PORTRAIT.region_rect.position.x = 64
			"critical": PORTRAIT.region_rect.position.x = 128


func pause_game() -> void:
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
	pause_menu = PAUSE_MENU_SCENE.instantiate()
	add_child(pause_menu)
	Global.is_mouse_captured = false
	get_tree().paused = true


func unpause_game() -> void:
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CAPTURED)
	pause_menu.queue_free()
	pause_menu = null
	Global.is_mouse_captured = true
	get_tree().paused = false
