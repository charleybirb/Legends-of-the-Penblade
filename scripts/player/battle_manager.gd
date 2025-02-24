extends Node

@export var DETECT_AREA : Area3D
@export var CAMERA_CONTROLLER : CameraController

var detected_enemies : Array

func _on_area_entered(area: Area3D) -> void:
	if !area.is_in_group("enemy_hitboxes"): return
	CAMERA_CONTROLLER.lock_on(area.get_parent().FOCUS_POINT)
	if detected_enemies == []:
		Global.is_in_battle = true
		Global.action_menu_manager.change_menu_mode()
	detected_enemies.append(area)


func _on_area_exited(area: Area3D) -> void:
	if !area.is_in_group("enemy_hitboxes"): return
	CAMERA_CONTROLLER.lock_off()
	detected_enemies.erase(area)
	if detected_enemies == []:
		Global.is_in_battle = false
		Global.action_menu_manager.change_menu_mode()


func _ready() -> void:
	connect_signals()


func connect_signals() -> void:
	DETECT_AREA.connect("area_entered", _on_area_entered)
	DETECT_AREA.connect("area_exited", _on_area_exited)
