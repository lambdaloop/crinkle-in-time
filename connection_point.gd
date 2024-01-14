extends Area2D
signal is_clicked

# Called when the node enters the scene tree for the first time.
func _ready():
	input_pickable = true
	self.connect("input_event", _on_Area2D_input_event)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_Area2D_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if event.is_pressed() && event.button_index == MOUSE_BUTTON_LEFT:
		print("I'm clicked!")
		is_clicked.emit()
