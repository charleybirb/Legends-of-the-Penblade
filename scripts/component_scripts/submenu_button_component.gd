extends Node

const FOCUS_STYLEBOX := preload("uid://crxse1k4aw41q")

@export var BUTTON_TITLE : String

var parent : SubMenuButton
var submenu : Control


func _on_mouse_entered() -> void:
	parent.set_modulate(Color(1,1,1,1))
	parent.add_theme_stylebox_override("panel", FOCUS_STYLEBOX)

func _on_mouse_exited() -> void:
	parent.set_modulate(Color(1,1,1,0.8))
	parent.remove_theme_stylebox_override("panel")


func _on_gui_input(event: InputEvent) -> void:
	if not event is InputEventMouseButton: return
	if  event.button_index != MOUSE_BUTTON_LEFT: return
	if event.is_pressed():
		parent.click()

func _ready() -> void:
	parent = get_parent()
	parent.BUTTON_LABEL.text = BUTTON_TITLE
	parent.set_modulate(Color(1,1,1,0.8))
	if parent.OPTION_MARKER:
		parent.OPTION_MARKER.visible = false
		parent.OPTIONS_HBOX.modulate = Color(1,1,1,0.6)
	connect_signals()
	if parent.OPTION_MARKER:
		await get_tree().create_timer(0.05).timeout
		parent.set_option(false)
		parent.OPTION_MARKER.visible = true


func connect_signals() -> void:
	parent.connect("gui_input", _on_gui_input)
	parent.connect("mouse_entered", _on_mouse_entered)
	parent.connect("mouse_exited", _on_mouse_exited)
	if parent.OPTION_MARKER:
		parent.connect("mouse_entered", Callable(parent, "_on_mouse_entered"))
		parent.connect("mouse_exited", Callable(parent, "_on_mouse_exited"))
