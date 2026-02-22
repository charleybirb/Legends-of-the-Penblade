extends MoveState


func check_relevance(input: InputPackage) -> StringName:
	if &"release" in input.actions:
		return &"fall"
	elif &"jump" in input.actions:
		return &"jump"
	return &"okay"
 

func enter(_previous_move_state: MoveState) -> void:
	VELOCITY_COMPONENT.velocity = Vector3.ZERO
