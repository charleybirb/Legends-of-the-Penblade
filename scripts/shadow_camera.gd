extends Camera3D

const Y_OFFSET := 4.077

@export var TARGET : CharacterBody3D

func _physics_process(delta: float) -> void:
	global_position.x = TARGET.global_position.x
	global_position.z = TARGET.global_position.z
	global_position.y = TARGET.global_position.y + Y_OFFSET
