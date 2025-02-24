extends Area3D


func _on_area_entered(area: Node3D) -> void:
	if area.get_parent().is_in_group("enemy"):
		print("left hand collided")


func _ready() -> void:
	area_entered.connect(_on_area_entered)
