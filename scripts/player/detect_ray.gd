extends RayCast3D

func _process(_delta: float) -> void:
	var collider : Node3D = get_collider()
	if not collider: return
	collider.is_target = true
