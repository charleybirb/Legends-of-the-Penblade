class_name CameraController
extends Node3D

@export var YAW_NODE : Node3D
@export var PITCH_NODE : Node3D
@export var SPRING_ARM_NODE : SpringArm3D
@export var CAMERA_NODE : Camera3D
@export var TARGET : Node3D
@export var INPUT_MANAGER : InputManager
@export var ROOT_MESH : Node3D

const FOLLOW_SPEED := 5.0

const DEFAULT_HEIGHT := 0.0
const MIN_HEIGHT := -0.7
const MAX_HEIGHT := 0.0
const HEIGHT_SENSITIVITY := 0.05
const HEIGHT_ACCELERATION := 0.0

const DEFAULT_SPRING_LENGTH := 3.795
const MAX_SPRING_LENGTH := 4.0
const MIN_SPRING_LENGTH := 2.8
const SPRING_SENSITIVITY := 0.08
const SPRING_ACCELERATION := 0.0

const DEFAULT_YAW := 0.0

const DEFAULT_PITCH := -8.4
const MAX_PITCH := 20
const MIN_PITCH := -50

const PITCH_ACCELERATION := 15
const YAW_ACCELERATION := 15

var spring_length : float = DEFAULT_SPRING_LENGTH
var yaw : float = DEFAULT_YAW
var pitch : float = DEFAULT_PITCH
var height : float = DEFAULT_HEIGHT

var pitch_direction : int = 1
var lock_on_target

func _ready() -> void:
	top_level = true
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CAPTURED)


func _input(event: InputEvent) -> void:
	if not (Global.is_mouse_captured and event is InputEventMouseMotion): return
	yaw += -event.relative.x * Global.h_sensitivity
	var last_pitch = pitch
	pitch = clamp((pitch + -event.relative.y * Global.v_sensitivity),
		MIN_PITCH,
		MAX_PITCH)
	pitch_direction = sign(pitch - last_pitch)
	
	spring_length = clamp((
		spring_length + (event.relative.y * SPRING_SENSITIVITY * Global.v_sensitivity)),
		MIN_SPRING_LENGTH,
		MAX_SPRING_LENGTH)
	height = clamp((
		height + event.relative.y * HEIGHT_SENSITIVITY * Global.v_sensitivity),
		MIN_HEIGHT,
		MAX_HEIGHT
		)


func _physics_process(delta: float) -> void:
	var input := INPUT_MANAGER.gather_input()
	if Global.is_mouse_captured:
		rotate_camera_with_mouse(input, delta)
	else:
		rotate_camera_with_buttons(input, delta)
	follow_target(delta)
	apply_position_offset(input, delta)
	input.queue_free()


func apply_position_offset(input: InputPackage, delta: float) -> void:
	#if input.input_direction == Vector2.ZERO:
	if input.input_direction.y == -1:
		height = lerp(
			height, 
			DEFAULT_HEIGHT, 
			HEIGHT_ACCELERATION * 0.9 * delta)
		spring_length = lerp(
			spring_length, 
			DEFAULT_SPRING_LENGTH, 
			SPRING_ACCELERATION * 0.7 * delta)
	SPRING_ARM_NODE.spring_length = lerp(
		SPRING_ARM_NODE.spring_length, spring_length, SPRING_ACCELERATION * delta)
	SPRING_ARM_NODE.position.y = lerp(
		SPRING_ARM_NODE.position.y, height, HEIGHT_ACCELERATION * delta)


func rotate_camera_with_mouse(input: InputPackage, delta: float) -> void:
		if input.input_direction.y == -1:
			pitch = lerp(pitch, DEFAULT_PITCH, PITCH_ACCELERATION * 0.06 * delta)
		if input.input_direction.x != 0:
			yaw += -input.input_direction.x * 0.8
		rotate_yaw(delta)
		rotate_pitch(delta)
		

func rotate_camera_with_buttons(input: InputPackage, delta: float) -> void:
	var sensitivity_multiplier := 4
	if "camera_left" in input.actions:
		yaw += -1 * Global.h_sensitivity * sensitivity_multiplier
		rotate_yaw(delta)
	if "camera_right" in input.actions:
		yaw += 1 * Global.h_sensitivity * sensitivity_multiplier
		rotate_yaw(delta)
	if "camera_up" in input.actions:
		pitch += 1 * Global.v_sensitivity * sensitivity_multiplier
		rotate_pitch(delta)
	if "camera_down" in input.actions:
		pitch += -1 * Global.v_sensitivity * sensitivity_multiplier
		rotate_pitch(delta)


func rotate_yaw(delta: float) -> void:
	YAW_NODE.rotation_degrees.y = lerp(
		YAW_NODE.rotation_degrees.y, 
		yaw, 
		YAW_ACCELERATION * delta)

func rotate_pitch(delta: float) -> void: 
	PITCH_NODE.rotation_degrees.x = lerp(
		PITCH_NODE.rotation_degrees.x, 
		pitch, 
		PITCH_ACCELERATION * delta)


func follow_target(delta: float):
	var target_position : Vector3 = TARGET.global_position if !lock_on_target else (
		(lock_on_target.global_position + TARGET.global_position) / 2)
	global_position.x = lerp(
		global_position.x, 
		target_position.x, 
		FOLLOW_SPEED * delta)
	global_position.z = lerp(
		global_position.z, 
		target_position.z, 
		FOLLOW_SPEED * delta)
	global_position.y = lerp(
		global_position.y, 
		target_position.y, 
		FOLLOW_SPEED * 0.8 * delta)
					   

func lock_on(new_target) -> void:
	lock_on_target = new_target

func lock_off() -> void:
	lock_on_target = null
