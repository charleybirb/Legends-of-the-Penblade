class_name ActionMenuManager
extends Node

const INACTIVE_POSITION_X := 0
const ACTIVE_POSITION_X := 30

@export var ACTION_MENU : ActionMenu
@export var ACTIVE_NORMAL_BUTTON_STYLEBOX : StyleBox
@export var ACTIVE_BATTLE_BUTTON_STYLEBOX : StyleBox

var menu_index := 1
var active_button : PanelContainer

func _unhandled_input(event: InputEvent) -> void:
	if not event is InputEventMouseButton: return
	if not event.pressed: return
	if event.button_index == MOUSE_BUTTON_WHEEL_UP:
		change_menu_position(-1)
	if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		change_menu_position(1)


func _ready() -> void:
	Global.action_menu_manager = self
	await get_tree().create_timer(0.1).timeout
	set_active_button()


func change_menu_position(direction: int) -> void:
	if active_button:
		active_button.z_index = 0
		active_button.remove_theme_stylebox_override("panel")
		var tween := get_tree().create_tween()
		var new_position := Vector2(INACTIVE_POSITION_X, active_button.position.y)
		tween.tween_property(active_button, "position", new_position, 0.1)
	menu_index += direction
	if menu_index > 4:
		menu_index = 1
	elif menu_index < 1:
		menu_index = 4
	set_active_button()


func set_active_button() -> void:
	match menu_index:
		1: active_button = ACTION_MENU.BUTTON1
		2: active_button = ACTION_MENU.BUTTON2
		3: active_button = ACTION_MENU.BUTTON3
		4: active_button = ACTION_MENU.BUTTON4
	active_button.z_index = 1
	var stylebox :=  ACTIVE_BATTLE_BUTTON_STYLEBOX if Global.is_in_battle else ACTIVE_NORMAL_BUTTON_STYLEBOX
	active_button.add_theme_stylebox_override("panel", stylebox)
	if !get_tree(): return #avoids crashing when closing the game, but i don't know why this is the one that crashes
	var tween2 := get_tree().create_tween()
	var new_position := Vector2(ACTIVE_POSITION_X, active_button.position.y)
	tween2.tween_property(active_button, "position", new_position, 0.1)


func change_menu_mode() -> void:
	ACTION_MENU.change_menu_mode()
	set_active_button()


func hide_action_menu() -> void:
	ACTION_MENU.visible = false


func show_action_menu() -> void:
	ACTION_MENU.visible = true
