class_name Enemy
extends CharacterBody3D

const TURN_SPEED := 200
const MOVE_SPEED := 3
const ACCELERATION := 4
const DECELERATION := 10
const FOLLOW_DISTANCE := 1.0
const WEIGHT := 1.0

@export var HURTBOX : Area3D
@export var DETECT_AREA : Area3D
@export var ANIMATION_PLAYER : AnimationPlayer
@export var FOCUS_POINT : Marker3D
@export var HEALTH_COMPONENT : HealthComponent

var health := 10
var defense := 1
var player : CharacterBody3D


func _on_body_detected(body: Node3D) -> void:
	if body.name != &"Player":
		return
	player = body
	print("player detected")
	#ANIMATION_PLAYER.play("walk", 0.3, 2.0)
	

func _on_body_undetected(body: Node3D) -> void:
	if body.name != &"Player":
		return
	player = null
	#ANIMATION_PLAYER.play("idle", 0.3)

func _ready() -> void:
	HEALTH_COMPONENT.connect(&"died", die)
	HURTBOX.connect(&"area_entered", Callable(HEALTH_COMPONENT, &"_on_area_entered"))
	DETECT_AREA.connect("body_entered", _on_body_detected)
	DETECT_AREA.connect("body_exited", _on_body_undetected)


func _physics_process(delta: float) -> void:
	if player:
		var to_player := player.global_transform.origin - global_transform.origin
		var distance := to_player.length()
		#var move_vector := to_player
		#move_vector.y = 0
		to_player = to_player.normalized()
		var acceleration := ACCELERATION * (distance - FOLLOW_DISTANCE)
		velocity = lerp(velocity, to_player * MOVE_SPEED, acceleration * delta)
		velocity.y = 0
		var right := global_transform.basis.x
		var r_dot := to_player.dot(right)
		
		rotation_degrees.y += TURN_SPEED * -r_dot * delta
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION * delta)
		velocity.z = move_toward(velocity.z, 0, DECELERATION * delta)
	move_and_slide()

func knockback(knockback_strength: float, direction: Vector3) ->  void:
	velocity = knockback_strength * direction
	
	
func die() -> void:
	queue_free()
		#return
	#ANIMATION_PLAYER.speed_scale = 4
	#await get_tree().create_timer(0.5).timeout
	#ANIMATION_PLAYER.speed_scale = 1
