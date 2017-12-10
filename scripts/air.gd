extends Sprite
onready var stok_air = utils.get_main_node()
func _ready():
	pass

func _picked_up():
	print("Air picked up")
	if stok_air.get_air() < 1:
		get_node("../../../error_message").show()
		get_node("../../../error_message/error_label").set_text("Water out of stock!!")
	else:
		stok_air.set_air_count(-1)
		get_node("../").set_fixed_process(false)
		get_node("../")._on_popup_pressed()
		get_node("../").set_fixed_process(true)
#	get_node("../skor").set_text(str(get_node("/root/object_state").air_value))
	set_hidden(true)

func _on_Area2D_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON and event.pressed == false:
	# Start dragging when the user presses the mouse button over the clickable area
		_picked_up()
