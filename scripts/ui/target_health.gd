extends TextureProgressBar

func _ready() -> void:
	SignalBus.enemy_health_changed.connect(update_healthbar)


func update_healthbar(curr_health: int, max_health: int) -> void:
	value = (float(curr_health) / float(max_health)) * 100.0
	
