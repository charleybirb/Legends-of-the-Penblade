class_name ActionMenuManager
extends Node

const INACTIVE_POSITION_X := 0
const ACTIVE_POSITION_X := 30

@export var ACTION_MENU : ActionMenu

var is_primary_action_blocked : bool = false
var is_seconday_action_blocked : bool = false

func _ready() -> void:
	SignalBus.primary_action_attempted.connect(attempt_primary_action)


func attempt_primary_action() -> void:
	if is_primary_action_blocked:
		SignalBus.primary_action_blocked.emit()
	SignalBus.primary_action_committed.emit(&"attack")


func hide_action_menu() -> void:
	ACTION_MENU.hide()


func show_action_menu() -> void:
	ACTION_MENU.show()
