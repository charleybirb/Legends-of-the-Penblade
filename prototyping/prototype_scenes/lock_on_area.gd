extends Area3D
@export var focus_point : MeshInstance3D


func _ready() -> void:
	add_to_group("enemy_hitboxes")
