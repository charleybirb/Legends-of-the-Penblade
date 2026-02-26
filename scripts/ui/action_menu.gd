class_name ActionMenu
extends Control

enum Mode { MELEE, MAGIC }

@export var MODE_LABEL : RichTextLabel
@export var QUICK_MENU_PANEL : PanelContainer
@export var MARGIN_CONTAINER : MarginContainer

const INACTIVE_POSITION_X := 0
const ACTIVE_POSITION_X := 30
const OPEN_VALUES := Vector2(182, 358) #size.y, position.y
const CLOSED_VALUES := Vector2(60, 480)

var is_primary_action_blocked : bool = false
var is_seconday_action_blocked : bool = false
var curr_mode : Mode = Mode.MELEE


func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed(&"switch_mode_up") or event.is_action_pressed(&"switch_mode_down")):
		if QUICK_MENU_PANEL.visible:
			pass
		else:
			switch_mode()
		return
	if event.is_action_pressed(&"quick_menu"):
		show_action_menu()
	elif event.is_action_released(&"quick_menu"):
		hide_action_menu()


func _ready() -> void:
	SignalBus.primary_action_attempted.connect(attempt_primary_action)
	hide_action_menu()
	

func switch_mode() -> void:
	match curr_mode:
		Mode.MELEE: 
			curr_mode = Mode.MAGIC
			MODE_LABEL.text = "[i]magic[/i]"
		Mode.MAGIC: 
			curr_mode = Mode.MELEE
			MODE_LABEL.text = "[i]melee[/i]"


func attempt_primary_action() -> void:
	if is_primary_action_blocked:
		SignalBus.primary_action_blocked.emit()
	SignalBus.primary_action_committed.emit(&"attack")


func hide_action_menu() -> void:
	QUICK_MENU_PANEL.hide()
	MARGIN_CONTAINER.size.y = CLOSED_VALUES.x
	MARGIN_CONTAINER.position.y = CLOSED_VALUES.y

func show_action_menu() -> void:
	QUICK_MENU_PANEL.show()
	MARGIN_CONTAINER.size.y = OPEN_VALUES.x
	MARGIN_CONTAINER.position.y = OPEN_VALUES.y
