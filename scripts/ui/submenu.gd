class_name SubMenu
extends PanelContainer

@export var right_elements : Control
@export var left_elements : Control
@export var back_button : SubMenuButton

var pause_menu : PauseMenu


func _on_back_button_clicked() -> void:
	var tween := get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(self, "modulate", Color(1,1,1,0), 0.2)
	await tween.finished
	pause_menu.open_main_pause_submenu()


func _ready() -> void:
	if back_button: back_button.connect("back_button_clicked", _on_back_button_clicked)
