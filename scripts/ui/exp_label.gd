extends RichTextLabel

@export var timer : Timer
var xp_gained : int = 0

func _ready() -> void:
	SignalBus.experience_gained.connect(gain_experience)
	timer.timeout.connect(to_next_level)


func gain_experience(amount: int) -> void:
	timer.stop()
	xp_gained += amount
	text = str(xp_gained) + "xp gained"
	Stats.xp += amount
	timer.start()


func to_next_level() -> void:
	xp_gained = 0
	var next_level : int = Stats.XP_LEVELS[Stats.level - 1] - Stats.xp
	if next_level <= 0:
		Stats.level += 1
		text = "Leveled up to " + str(Stats.level) + "!"
	else:
		text = str(next_level) + "xp until next level"
	await get_tree().create_timer(1.0).timeout
	text = ""
