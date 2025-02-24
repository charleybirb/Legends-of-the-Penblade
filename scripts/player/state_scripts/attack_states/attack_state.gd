class_name AttackState
extends Node

const BASE_STRENGTH : int = 1

@export var COLLISION_AREA : Area3D
@export var STRENGTH_MULTIPLIER : float = 1.0
@export var KNOCKBACK_STRENGTH : float = 10.0

var ANIMATION_PLAYER : AnimationPlayer
var ATTACKER : CharacterBody3D
var enemies_hit := []


func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("enemy_hitboxes"):
		var enemy : Enemy = area.get_parent()
		if not enemy in enemies_hit:
			attack_enemy(enemy)


func _ready() -> void:
	COLLISION_AREA.connect("area_entered", _on_area_entered)
			

func exit() -> void:
	Global.debug.remove_label("EnemyAttacked")
	COLLISION_AREA.monitoring = false
	enemies_hit.clear()


func attack_enemy(enemy: Enemy) -> void:
	enemies_hit.append(enemy)
	enemy.take_damage(round(BASE_STRENGTH * STRENGTH_MULTIPLIER))
	enemy.knockback(KNOCKBACK_STRENGTH, ATTACKER.direction)
	Global.debug.update_label("EnemyAttacked", str(enemies_hit))
	

func play_animation(animation: String, blend:=-1.0, speed:=1.0) -> void:
	if ANIMATION_PLAYER.current_animation == animation: return
	ANIMATION_PLAYER.play(animation, blend, speed)
