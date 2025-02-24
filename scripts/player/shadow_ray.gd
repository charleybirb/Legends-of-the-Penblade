extends RayCast3D

const Y_OFFSET := 0.04

@export var SHADOW : Sprite3D

func _process(_delta: float) -> void:
	if get_collider():
		if SHADOW.visible == false: SHADOW.visible = true  
		SHADOW.global_position.y = get_collision_point().y + Y_OFFSET
		SHADOW.modulate = Color(1,1,1, 1 - ((global_position.y - get_collision_point().y) / 4))
	else:
		if SHADOW.visible == true:
			SHADOW.visible = false
