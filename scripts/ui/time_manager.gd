extends Node

var hours := 0
var minutes := 0
var seconds := 0

func _ready() -> void:
	tick_clock()

func tick_clock() -> void:
	await get_tree().create_timer(1.0).timeout
	seconds += 1
	if seconds == 60:
		minutes += 1
		seconds = 0
	if minutes == 60:
		hours += 1
		minutes = 0
	set_time()
	tick_clock()

func set_time() -> void:
	var hours_string := add_zero_to_beginning(str(hours))
	var minutes_string := add_zero_to_beginning(str(minutes))
	var seconds_string := add_zero_to_beginning(str(seconds))
	Global.time = hours_string + ":" + minutes_string + ":" + seconds_string
	

func add_zero_to_beginning(raw_string: String) -> String:
	if raw_string.length() == 1:
		raw_string = "0" + raw_string
	return raw_string
