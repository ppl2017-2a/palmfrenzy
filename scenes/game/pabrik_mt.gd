extends Sprite
func _ready():
	pass
func _picked_up():
	if get_parent().get_production_speed() < 30:
		utils.get_main_node().set_uang_count(-80)
#		object_state.p_uang-=80
	elif get_parent().get_production_speed() > 30 and get_parent().get_production_speed() < 50:
		utils.get_main_node().set_uang_count(-40)
#		object_state.p_uang-=40
	else:
		utils.get_main_node().set_uang_count(-20)
#		object_state.p_uang-=20
	print("Maintenance picked up")
	get_parent().maintened()
#	get_node("../").set_fixed_process(false)
#	get_node("../")._update_produksi()
#	get_node("../").set_fixed_process(true)
#	get_node("../skor").set_text(str(get_node("/root/object_state").air_value))
	set_hidden(true)

func _on_Area2D_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON and event.pressed == false:
	# Start dragging when the user presses the mouse button over the clickable area
		_picked_up()
