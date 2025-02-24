extends Label

func _physics_process(_delta: float) -> void:
	if text != Global.time:
		text = Global.time
	
