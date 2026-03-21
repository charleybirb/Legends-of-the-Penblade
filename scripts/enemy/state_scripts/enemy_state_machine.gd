extends Node
class_name EnemyStateMachine

signal player_detected(player: Player)
signal player_lost
signal attack_triggered

enum AlertState { IDLE, WAKE, SEARCH, CHASE, ATTACK }

@export var DETECT_AREA : Area3D
@export var ATTACK_RAY : RayCast3D
@export var MOVE_STATE_MACHINE : EnemyMoveStateMachine

var curr_alert : AlertState = AlertState.IDLE


func _on_player_detected(_detected_player: Player) -> void:
	if curr_alert == AlertState.IDLE:
		curr_alert = AlertState.WAKE
		await get_tree().create_timer(1.0).timeout
		curr_alert = AlertState.CHASE
	else:
		curr_alert = AlertState.CHASE


func _on_player_lost() -> void:
	curr_alert = AlertState.SEARCH


func _on_body_detected(body: Node3D) -> void:
	if not body is Player:
		return
	player_detected.emit(body)
	

func _on_body_undetected(body: Node3D) -> void:
	if not body is Player:
		return
	player_lost.emit()


func _ready() -> void:
	DETECT_AREA.connect("body_entered", _on_body_detected)
	DETECT_AREA.connect("body_exited", _on_body_undetected)
	player_detected.connect(_on_player_detected)
	player_detected.connect(Callable(MOVE_STATE_MACHINE, &"_on_player_detected"))
	player_lost.connect(_on_player_lost)
	attack_triggered.connect(Callable(MOVE_STATE_MACHINE, &"_on_attack_triggered"))
	

func _process(_delta: float) -> void:
	if curr_alert == AlertState.CHASE:
		check_attack_ray()


func check_attack_ray() -> void:
	var collider : Node3D = ATTACK_RAY.get_collider()
	if not collider: return
	if collider is Player:
		var collision_point : Vector3 = ATTACK_RAY.get_collision_point()
		if (collision_point - get_parent().global_position).length() <= 2.0:
			curr_alert = AlertState.ATTACK
			attack_triggered.emit()
			await get_tree().create_timer(2.0).timeout
			curr_alert = AlertState.CHASE
