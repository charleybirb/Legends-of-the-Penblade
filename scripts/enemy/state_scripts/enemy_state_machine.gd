extends Node
class_name EnemyStateMachine

signal player_detected(player: Player)
signal player_lost

enum AlertState { IDLE, WAKE, SEARCH, CHASE, ATTACK }

@export var DETECT_AREA : Area3D
@export var ALERT_STATE_MACHINE : EnemyAlertStateMachine
@export var MOVE_STATE_MACHINE : EnemyMoveStateMachine

var curr_alert : AlertState = AlertState.IDLE


func _on_player_detected(_detected_player: Player) -> void:
	if curr_alert == AlertState.IDLE:
		curr_alert = AlertState.WAKE
	else:
		curr_alert = AlertState.CHASE


func _on_player_lost() -> void:
	if curr_alert == AlertState.CHASE:
		pass


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
