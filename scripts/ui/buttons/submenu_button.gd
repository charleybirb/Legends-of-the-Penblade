class_name SubMenuButton
extends PanelContainer

@export var BUTTON_LABEL : Label
@export var OPTION_MARKER : PanelContainer
@export var OPTIONS_HBOX : HBoxContainer

var option_index : int

func _on_mouse_entered() -> void:
	OPTIONS_HBOX.modulate = Color(1,1,1,0.8)

func _on_mouse_exited() -> void:
	OPTIONS_HBOX.modulate = Color(1,1,1,0.4)


func click() -> void:
	var number_of_options := OPTIONS_HBOX.get_child_count() - 1
	if number_of_options > 0:
		option_index += 1
		if option_index > number_of_options:
			option_index = 1
	set_option()


func get_option_position() -> float:
	var child_index := option_index
	var option := OPTIONS_HBOX.get_child(child_index)
	var option_position : float = option.global_position.x
	option_position -= OPTION_MARKER.size.x / 2
	option_position += option.size.x / 2
	return option_position


func set_option(_is_tweened:=true) -> void:
	pass
