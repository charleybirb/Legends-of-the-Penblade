extends Node
class_name HealthComponent

signal died
signal damage_taken(dmg_amount: float)
signal healed(health_amount: float)

@export var MAX_HEALTH : float = 4.0
@export var DEFENCE : float = 0.0
@export var HURTBOX : Area3D
@export var INVINSIBILITY_TIMER : Timer

@onready var curr_health : float = MAX_HEALTH

var can_take_damage : bool = true


func _on_area_entered(area: Area3D) -> void:
	if not can_take_damage: return
	if area.owner is Player:
		var player : Player = area.owner
		take_damage(player.full_strength)
		can_take_damage = false
		INVINSIBILITY_TIMER.start()


func _on_timer_timeout() -> void:
	can_take_damage = true


func _ready() -> void:
	INVINSIBILITY_TIMER.connect(&"timeout", _on_timer_timeout)
	#HURTBOX.add_to_group(&"hurtboxes")


func take_damage(dmg_amount: float) -> void:
	curr_health -= dmg_amount - DEFENCE
	if curr_health <= 0.0:
		died.emit()
		return
	damage_taken.emit(dmg_amount)
	print(curr_health)


func heal(health_amount: float) -> void:
	if curr_health == MAX_HEALTH: return
	curr_health += health_amount
	curr_health = clamp(curr_health, 0.0, MAX_HEALTH)
	healed.emit(health_amount)
	
