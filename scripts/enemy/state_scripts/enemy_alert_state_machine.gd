extends Node
class_name EnemyAlertStateMachine

enum AlertState { IDLE, WAKE, SEARCH, CHASE, ATTACK }

var ANIMATION_PLAYER : AnimationPlayer
var player : Player
var curr_state : EnemyAlertState

@onready var states : Dictionary[StringName, EnemyAlertState] = {
	&"idle": $Idle,
	&"wake": $Wake,
	#&"search": $Search,
	&"chase": $Chase,
	#&"attack": $Attack,
}


func _on_player_detected(detected_player: Player) -> void:
	player = detected_player
	change_alert_state(AlertState.WAKE)


func _on_player_lost() -> void:
	player = null
	

func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	for state : EnemyAlertState in states.values():
		state.ANIMATION_PLAYER = ANIMATION_PLAYER
	curr_state = states[&"idle"]


func change_alert_state(new_state: AlertState) -> void:
	match new_state:
		AlertState.IDLE:
			pass
		AlertState.WAKE:
			curr_state = states[&"wake"]
			curr_state.enter()
		AlertState.SEARCH:
			pass
		AlertState.CHASE:
			pass
		AlertState.ATTACK:
			pass
