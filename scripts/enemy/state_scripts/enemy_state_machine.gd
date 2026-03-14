extends Node
class_name EnemyStateMachine

signal player_detected(player: Player)
signal player_lost

@export var DETECT_AREA : Area3D
@export var ALERT_STATE_MACHINE : EnemyAlertStateMachine
@export var MOVE_STATE_MACHINE : EnemyMoveStateMachine
@export var ANIMATION_PLAYER : AnimationPlayer


func _on_body_detected(body: Node3D) -> void:
	if not body is Player:
		return
	player_detected.emit(body)
	

func _on_body_undetected(body: Node3D) -> void:
	if not body is Player:
		return
	player_lost.emit()


func _ready() -> void:
	ALERT_STATE_MACHINE.ANIMATION_PLAYER = ANIMATION_PLAYER
	DETECT_AREA.connect("body_entered", _on_body_detected)
	DETECT_AREA.connect("body_exited", _on_body_undetected)
	player_detected.connect(Callable(ALERT_STATE_MACHINE, &"_on_player_detected"))
	player_detected.connect(Callable(MOVE_STATE_MACHINE, &"_on_player_detected"))
	player_lost.connect(Callable(ALERT_STATE_MACHINE, &"_on_player_lost"))
	
