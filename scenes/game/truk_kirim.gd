extends Sprite
#
#var nilai = false
onready var koin = get_node("Area2D")
func _ready():
	pass
func _picked_up():
#	nilai = true
	print("Kirim picked up")
	object_state.truk_kirim_status = true
	object_state.truk_value = 0
	get_node("../").set_fixed_process(false)
#	get_node("../")._on_cek_panen()
	get_node("../").set_is_truk_kirim(true)
	get_node("../").set_process(true)
	set_hidden(true)
#
func _on_Area2D_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON and event.pressed == false:
	# Start dragging when the user presses the mouse button over the clickable area
		_picked_up()
