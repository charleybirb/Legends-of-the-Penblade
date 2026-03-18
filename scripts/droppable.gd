extends RigidBody3D
class_name Dropable

@export var texture : CompressedTexture2D
@export var sprite : Sprite3D
@export var collect_area : Area3D


func _on_body_entered(body: Node3D) -> void:
	if not body is Player: return
	var tween : Tween = get_tree().create_tween()
	var player_position : Vector3 = Vector3(body.global_position.x, body.global_position.y + 1, body.global_position.z)
	tween.tween_property(sprite, "global_position", player_position, 0.5)
	tween.play()
	await tween.finished
	queue_free()


func _ready() -> void:
	sprite.texture = texture
	apply_central_impulse(Vector3(randf_range(-2.0, 2.0), 0.0, randf_range(-2.0, 2.0)))
	collect_area.body_entered.connect(_on_body_entered)
