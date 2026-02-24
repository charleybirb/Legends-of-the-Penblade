extends Node
class_name SFXManager

@export var SFX_NODES : Array[AudioStreamPlayer3D]
@export var SOUNDS : Dictionary[StringName, String]
@export var ground_type : String = "carpet"

var FOOTSTEP_SOUNDS : Array[String] #uids of the footstep sounds associated with the current ground type


func _ready() -> void:
	for sound_name : StringName in SOUNDS.keys():
		if sound_name.begins_with(ground_type):
			FOOTSTEP_SOUNDS.append(SOUNDS[sound_name])

func play_sound(sound: AudioStream) -> void:
	for sfx: AudioStreamPlayer3D in SFX_NODES:
		if not sfx.playing:
			sfx.set_stream(sound)
			sfx.play()
			break


func get_sound(sound_name: StringName) -> void:
	var sound_array : Array
	for sound: StringName in SOUNDS.keys():
		if sound.begins_with(sound_name):
			sound_array.append(sound)
	if sound_array == []:
		push_warning(sound_name, " sound does not exist")
		return
	var sound: AudioStream = load(SOUNDS[sound_array.pick_random()])
	play_sound(sound)


func play_footstep() -> void:
	var sound : AudioStream = load(FOOTSTEP_SOUNDS.pick_random())
	play_sound(sound)
	
