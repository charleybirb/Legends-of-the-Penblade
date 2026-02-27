extends Node

enum Track { DEFENDER, MAGE, STRIDER, NONE }

var strength : int = 3
var defense : int = 1
var max_mp : int = 3
var max_hp : int = 5
var ep : int = 0 # experience point
var level : int = 1

var chosen_track : Track
