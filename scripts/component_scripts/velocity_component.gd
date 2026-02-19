class_name VelocityComponent
extends Node

@export var TARGET : CharacterBody3D
@export var ROOT_MESH : Node3D

const MAX_FALL_VELOCITY := -8.0

var velocity : Vector3
var direction : Vector3
var last_direction : Vector3
var last_camera_rotation : float

func update_velocity(input: InputPackage, speed: float, acceleration: float, delta: float) -> void:
	direction = Vector3(input.input_direction.x, 0, input.input_direction.y)
	if direction != last_direction and TARGET.is_on_floor(): acceleration *= 6
	last_direction = direction
	
	direction *= TARGET.transform.basis
	direction = direction.rotated(Vector3.UP, TARGET.CAMERA_CONTROLLER.YAW_NODE.rotation.y)
	last_camera_rotation = TARGET.CAMERA_CONTROLLER.YAW_NODE.rotation.y
	if Global.is_in_battle: speed += 1.5
	var new_velocity := Vector3(speed * direction.normalized().x, 0, speed * direction.normalized().z)
	velocity.x = lerp(velocity.x, new_velocity.x, acceleration * delta)
	velocity.z = lerp(velocity.z, new_velocity.z, acceleration * delta)
	#print(velocity)


func kill_velocity(deceleration: float, delta: float) -> void:
	velocity.x = move_toward(TARGET.velocity.x, 0, deceleration * delta)
	velocity.z = move_toward(TARGET.velocity.z, 0, deceleration * delta)


func update_rotation(rotation_speed: float, delta: float, is_idle: = false) -> void:
	var target_direction := (last_direction * TARGET.transform.basis).rotated(
		Vector3.UP, last_camera_rotation) if is_idle else direction
	var target_rotation := atan2(target_direction.x, target_direction.z) - TARGET.rotation.y
	ROOT_MESH.rotation.y = lerp_angle(ROOT_MESH.rotation.y, target_rotation, rotation_speed *  delta)
	TARGET.direction = ROOT_MESH.global_transform.basis.z

func jump(jump_height: float, apex_duration: float) -> void:
	velocity.y = 2 * jump_height / apex_duration


func fall() -> void:
	if velocity.y > 0.0: velocity.y /= 4


func apply_movement() -> void:
	TARGET.velocity = velocity
	TARGET.move_and_slide()


func apply_gravity(delta: float, gravity_multiplier:= 1.0) -> void:
	velocity.y += (TARGET.get_gravity().y * gravity_multiplier) * delta
	if velocity.y < MAX_FALL_VELOCITY: velocity.y = MAX_FALL_VELOCITY
