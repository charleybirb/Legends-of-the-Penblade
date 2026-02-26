extends Node3D
class_name SFXManager

@export var SFX_NODES : Array[AudioStreamPlayer3D]
@export var SOUNDS : Dictionary[StringName, String]
@export var ground_type : String = "carpet"

var footstep_sounds : Array[String] #uids of the footstep sounds associated with the current ground type


func _ready() -> void:
	for sound_name : StringName in SOUNDS.keys():
		if sound_name.begins_with(ground_type):
			footstep_sounds.append(SOUNDS[sound_name])


func play_sound(sound: AudioStream) -> void:
	var sfx_blocked : int = 0
	var curr_sfx : AudioStreamPlayer3D
	for sfx: AudioStreamPlayer3D in SFX_NODES:
		if not sfx.playing:
			curr_sfx = sfx
			break
		sfx_blocked += 1
	if sfx_blocked == SFX_NODES.size():
		curr_sfx = SFX_NODES.pick_random()
	curr_sfx.set_stream(sound)
	curr_sfx.play()


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
	var sound : AudioStream = load(footstep_sounds.pick_random())
	play_sound(sound)
	
