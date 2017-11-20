extends Sprite

onready var koin = get_node("Area2D")
func _ready():
	pass
func _picked_up():
	print("Air picked up")
	object_state.p_uang+=100
	get_node("../").set_fixed_process(false)
	get_node("../")._on_popup_pressed()
	get_node("../").set_fixed_process(true)
#	get_node("../skor").set_text(str(get_node("/root/object_state").air_value))
	set_hidden(true)

func _on_Area2D_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON and event.pressed == false:
	# Start dragging when the user presses the mouse button over the clickable area
		_picked_up()
