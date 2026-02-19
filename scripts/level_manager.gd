class_name LevelManager
extends Node

const LEVEL_SCENES := {
	"prototype_level": preload("uid://bx0tnf4mos5bh")
}

@export var LevelViewport : Viewport

var current_level : String


func _ready() -> void:
	Global.level_manager = self


func create_level(new_level_name: String) -> void:
	if LevelViewport.get_child_count() > 0:
		LevelViewport.get_child(0).queue_free()
	current_level = new_level_name
	var new_level = LEVEL_SCENES[current_level]
	LevelViewport.add_child(new_level)
