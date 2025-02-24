class_name PauseMenu
extends PanelContainer

@export var MENU_CONTAINER : PanelContainer
@export var MENU_TITLE_LABEL : Label
@export var MENU_TITLE_CONTAINER : PanelContainer
@export var MAIN_PAUSE_MENU_SCENE : PackedScene

var submenu : SubMenu = null


func _on_submenu_opened(new_submenu: PackedScene, menu_title: String) -> void:
	open_submenu(new_submenu, menu_title)


func _ready() -> void:
	print("paused")
	submenu = MENU_CONTAINER.get_child(0)
	submenu.pause_menu = self
	MENU_TITLE_CONTAINER.modulate = Color(1,1,1,0)
	MENU_TITLE_CONTAINER.position = Vector2(-3, 109)


func open_submenu(new_submenu_scene: PackedScene, menu_title: String) -> void:
	submenu.queue_free()
	if menu_title == "": 
		clear_menu_title()
	var new_submenu : SubMenu = new_submenu_scene.instantiate()
	submenu = new_submenu
	submenu.pause_menu = self
	MENU_CONTAINER.add_child(submenu)
	if menu_title != "": set_menu_title(menu_title)
	

func set_menu_title(menu_title: String) -> void:
	print(menu_title)
	MENU_TITLE_LABEL.text = menu_title
	var tween := get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(MENU_TITLE_CONTAINER, "position", Vector2(-3, -14), 0.5)
	tween.parallel().tween_property(MENU_TITLE_CONTAINER, "modulate", Color(1,1,1,1), 0.3)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)

func clear_menu_title() -> void:
	var tween := get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(MENU_TITLE_CONTAINER, "position", Vector2(-3, 109), 0.5)
	tween.parallel().tween_property(MENU_TITLE_CONTAINER, "modulate", Color(1,1,1,0), 0.3)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)


func open_main_pause_submenu() -> void:
	open_submenu(MAIN_PAUSE_MENU_SCENE, "")
