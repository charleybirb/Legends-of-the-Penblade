extends Node

@export var FOLLOW_SPEED := 6
@export var FOLLOW_DISTANCE := 0.2
@export var TARGET : Node3D
@export var is_top_level := false
@export var is_ahead := true
var parent : Node3D

func _ready() -> void:
	parent = get_parent()
	if is_top_level: parent.top_level = is_top_level
	

func _physics_process(delta: float) -> void:
	if !parent or !TARGET: return
	var to_target := TARGET.global_transform.origin - parent.global_transform.origin
	var distance := to_target.length()
	var move_vector := to_target
	to_target = to_target.normalized()
	
	var acceleration = distance - FOLLOW_DISTANCE
	parent.global_transform.origin += acceleration * move_vector * FOLLOW_SPEED * delta
