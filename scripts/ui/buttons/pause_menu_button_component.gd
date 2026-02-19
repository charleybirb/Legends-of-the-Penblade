extends Node

signal submenu_opened(submenu: SubMenu, menu_title: String)
signal submenu_closed

const FOCUS_STYLEBOX := preload("uid://crxse1k4aw41q")

@export var SUBMENU_SCENE : PackedScene
@export var BUTTON_TITLE : String

var parent : PanelContainer
var is_submenu_opened := false
@onready var submenu := $"../../../.."

func _on_mouse_entered() -> void:
	parent.set_modulate(Color(1,1,1,1))
	parent.add_theme_stylebox_override("panel", FOCUS_STYLEBOX)

func _on_mouse_exited() -> void:
	parent.set_modulate(Color(1,1,1,0.8))
	parent.remove_theme_stylebox_override("panel")

func _on_gui_input(event: InputEvent) -> void:
	if not event is InputEventMouseButton: return
	if  event.button_index != MOUSE_BUTTON_LEFT and not event.is_pressed(): return
	if SUBMENU_SCENE: open_submenu()
	else: 
		get_tree().paused = false
		get_tree().quit()


func _ready() -> void:
	parent = get_parent()
	parent.BUTTON_LABEL.text = BUTTON_TITLE
	parent.set_modulate(Color(1,1,1,0.8))
	await get_tree().create_timer(0.1).timeout
	connect_signals()


func open_submenu() -> void:
	if is_submenu_opened: return
	is_submenu_opened = true
	submenu_opened.emit(SUBMENU_SCENE, BUTTON_TITLE)


func close_submenu() -> void:
	submenu_closed.emit()
	is_submenu_opened = false


func connect_signals() -> void:
	submenu_opened.connect(Callable(submenu.pause_menu, "_on_submenu_opened"))
	submenu_closed.connect(Callable(submenu.pause_menu, "_on_submenu_closed"))
	parent.connect("gui_input", _on_gui_input)
	parent.connect("mouse_entered", _on_mouse_entered)
	parent.connect("mouse_exited", _on_mouse_exited)
