extends Node

#Action Signals
signal primary_action_attempted
signal primary_action_committed(action_name: StringName)
signal primary_action_blocked
signal secondary_action_attempted
signal secondary_action_committed(action_name: StringName)
signal secondary_action_blocked

#Debug Signals
signal debug_updated(title: String, value: String)
signal debug_removed(title: String)
