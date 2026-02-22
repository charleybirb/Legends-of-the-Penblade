class_name InputManager
extends Node

var new_input : InputPackage

func gather_input() -> InputPackage:
	new_input = InputPackage.new()
	check_action(&"secondary_action")
	check_action(&"primary_action")
	check_action(&"jump")
	check_action_modifier(&"walk")
	
	new_input.input_direction = Input.get_vector(
		&"move_left", &"move_right", 
		&"move_forward", &"move_back")
	new_input.camera_direction = Input.get_vector(
		&"camera_left", &"camera_right",
		&"camera_up", &"camera_down"
	)
	
	if new_input.input_direction != Vector2.ZERO:
		new_input.actions.append(&"run")
	
	if new_input.actions.is_empty():
		new_input.actions.append(&"idle")
	
	return new_input


func check_action(action: StringName) -> void:
	if Input.is_action_just_pressed(action):
		new_input.actions.append(action)
	elif Input.is_action_just_released(action):
		new_input.released_actions.append(action)

func check_action_modifier(action_modifier: String) -> void:
	if Input.is_action_pressed(action_modifier):
		new_input.action_modifiers.append(action_modifier)
	elif Input.is_action_just_released(action_modifier):
		new_input.released_action_modifiers.append(action_modifier)
	
