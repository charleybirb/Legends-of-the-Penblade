extends Node

@export var PUSH_STRENGTH : float
@export var VELOCITY_COMPONENT : VelocityComponent

var parent : CharacterBody3D

@onready var PUSH_RAYS := [
	$"../RayCast3D", 
	$"../RayCast3D2", 
	$"../RayCast3D3", 
	$"../RayCast3D4"
]


func _ready() -> void:
	parent = get_parent()


func _process(_delta: float) -> void:
	#if !parent.is_on_floor():
		#if !PUSH_RAYS[0].enabled:
			#for ray in PUSH_RAYS:
				#ray.enabled = true
		#var enemy : Enemy
	for ray in PUSH_RAYS:
		if ray.get_collider() is Enemy:
				push_enemy(ray.get_collider())
	#else:
		#var enemy : Enemy
		#for ray in PUSH_RAYS:
			#if ray.get_collider() is Enemy:
				#enemy = ray.get_collider()
		#if enemy:
			#push_enemy(enemy)
			#return
		#if PUSH_RAYS[0].enabled:
			#for ray in PUSH_RAYS:
				#ray.enabled = false

func push_enemy(enemy: Enemy) -> void:
	if enemy: enemy.knockback(PUSH_STRENGTH, enemy.global_transform.basis.z)
	var direction = VELOCITY_COMPONENT.ROOT_MESH.global_transform.basis.z
	if VELOCITY_COMPONENT.velocity == Vector3.ZERO:
		VELOCITY_COMPONENT.velocity += direction * 10
	else:
		VELOCITY_COMPONENT.velocity += direction * 0.3
