class_name DebugPanel
extends PanelContainer

@export var vbox : VBoxContainer
var debug_labels := {}

func _ready() -> void:
	Global.debug = self
	#DisplayServer.window_set_position(DisplayServer.screen_get_size() / 4)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("debug"):
		visible = !visible
		
	
func _physics_process(_delta: float) -> void:
	update_label("FPS", str(Engine.get_frames_per_second()))


func add_label(title: String, value: String) -> void:
	var new_label := Label.new()
	vbox.add_child(new_label)
	new_label.name = title + "Label"
	new_label.text = title + " : " + value
	debug_labels.merge({title: new_label})


func update_label(title: String, value: String) -> void:
	if not title in debug_labels:
		add_label(title, value)
		return
	var new_text := title + " : " + value
	var debug_label : Label = debug_labels[title]
	if debug_label.text == new_text:
		return
	debug_label.text = new_text
	

func remove_label(title: String) -> void:
	if not title in debug_labels:
		#push_warning("debug label " + title + " does not exist")
		return
	var label_to_delete : Label = debug_labels[title]
	debug_labels.erase(title)
	label_to_delete.queue_free()
