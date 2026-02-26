extends Node


var level_manager : LevelManager
var debug : DebugPanel

var time: String = "00:00:00"

var v_sensitivity := 0.1
var h_sensitivity := 0.2

var is_camera_automatic := true
var is_mouse_captured := true
var is_in_battle := false
var is_keyboard_mode := true
var was_grounded := false
