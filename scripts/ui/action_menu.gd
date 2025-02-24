class_name ActionMenu
extends PanelContainer

@export var BUTTON1 : PanelContainer
@export var BUTTON2 : PanelContainer
@export var BUTTON3 : PanelContainer
@export var BUTTON4 : PanelContainer
@export var NORMAL_THEME : Theme
@export var BATTLE_THEME : Theme
@export var TITLE_PANEL : PanelContainer
@export var TITLE_PANEL_BATTLE_STYLEBOX : StyleBox
@export var TITLE_PANEL_NORMAL_STYLEBOX : StyleBox

func change_menu_mode() -> void:
	theme = BATTLE_THEME if Global.is_in_battle else NORMAL_THEME
	var title_panel_stylebox = TITLE_PANEL_BATTLE_STYLEBOX if Global.is_in_battle else TITLE_PANEL_NORMAL_STYLEBOX
	TITLE_PANEL.remove_theme_stylebox_override("panel")
	TITLE_PANEL.add_theme_stylebox_override("panel", title_panel_stylebox)
