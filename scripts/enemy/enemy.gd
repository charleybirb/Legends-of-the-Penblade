class_name Enemy
extends CharacterBody3D


@export var HURTBOX : Area3D
@export var DETECT_AREA : Area3D
@export var FOCUS_POINT : Marker3D
@export var HEALTH_COMPONENT : HealthComponent
@export var STATE_MACHINE : EnemyMoveStateMachine

var is_target : bool = false
var defense := 1
var xp : int = 1
var player : CharacterBody3D





func _ready() -> void:
	HEALTH_COMPONENT.connect(&"died", die)
	HEALTH_COMPONENT.connect(&"damage_taken", update_healthbar)
	HURTBOX.connect(&"area_entered", Callable(HEALTH_COMPONENT, &"_on_area_entered"))



func _physics_process(delta: float) -> void:
	if is_target: 
		is_target = false
		update_healthbar(HEALTH_COMPONENT.curr_health, HEALTH_COMPONENT.MAX_HEALTH)
	STATE_MACHINE.physics_update(delta)
	#if player:
		#var to_player := player.global_transform.origin - global_transform.origin
		#var distance := to_player.length()
		#to_player = to_player.normalized()
		#var acceleration := ACCELERATION * (distance - FOLLOW_DISTANCE)
		#velocity = lerp(velocity, to_player * MOVE_SPEED, acceleration * delta)
		#velocity.y = 0
		#var right := global_transform.basis.x
		#var r_dot := to_player.dot(right)
		#
		#rotation_degrees.y += TURN_SPEED * -r_dot * delta
	#else:
		#velocity.x = move_toward(velocity.x, 0, DECELERATION * delta)
		#velocity.z = move_toward(velocity.z, 0, DECELERATION * delta)
	move_and_slide()


func knockback(knockback_strength: float, direction: Vector3) ->  void:
	velocity = knockback_strength * direction


func update_healthbar(curr_health: float, max_health: float) -> void:
	SignalBus.enemy_health_changed.emit(curr_health, max_health)


func die() -> void:
	SignalBus.experience_gained.emit(xp)
	queue_free()
