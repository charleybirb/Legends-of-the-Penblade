extends CharacterBody3D

@export_group("ConnectedNodes")
@export var INPUT_MANAGER : InputManager
@export var CAMERA_CONTROLLER : CameraController
@export var STATE_MACHINES : PlayerStateMachine

var direction : Vector3

func _physics_process(delta: float) -> void:
	var input = INPUT_MANAGER.gather_input()
	STATE_MACHINES.MOVE_STATE_MACHINE.physics_update(input, delta)
	input.queue_free()


func _process(delta: float) -> void:
	var input = INPUT_MANAGER.gather_input()
	STATE_MACHINES.MOVE_STATE_MACHINE.update(input, delta)
	input.queue_free()
	#STATE_MACHINES.ATTACK_STATE_MACHINE.update(input, delta)
