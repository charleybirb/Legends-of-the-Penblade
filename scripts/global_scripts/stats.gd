extends Node

enum Track { DEFENDER, MAGE, STRIDER, NONE }

const XP_LEVELS : Array[int] = [
	5, 20, 45, 60, 90, 150, 290, 390, 500
]

var strength : int = 3
var defense : int = 1
var max_mp : int = 3
var max_hp : int = 5
var xp : int = 0 # experience point
var level : int = 1

var chosen_track : Track
