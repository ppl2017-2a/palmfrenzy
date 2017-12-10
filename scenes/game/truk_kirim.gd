extends Sprite
var id_truk
func _ready():
	id_truk = get_parent().my_key
	pass
func _picked_up():
#	properti.get_hasil_panen() + 1*properti.get_truk_count() > 5*properti.get_truk_count()
	if (utils.get_main_node().get_produksi_pabrik() !=0 and utils.get_main_node().get_produksi_pabrik() - 5*utils.get_main_node().get_pabrik_count() == 0)or\
	  (utils.get_main_node().get_produksi_pabrik()+5 > (utils.get_main_node().get_pabrik_count() * 5)):
#	if object_state.pabrik_value !=0 and object_state.pabrik_value % 3 == 0:
		get_node("../../../error_message").show()
		get_node("../../../error_message/error_label").set_text("Factory is full!!")
	else:
		print("Kirim picked up")
		object_state.truk_kirim_status = true
		object_state.pabrik_received = true
#		object_state.pabrik_value += 1
		utils.get_main_node().set_produksi_pabrik(5)
		utils.get_main_node().set_hasil_panen(0,true)
		utils.get_main_node().update_truk_value(0,true)
#		object_state.truk_value = 0
		get_parent().set_fixed_process(false)
		get_parent().set_is_truk_kirim(true)
		get_parent().set_process(true)
		set_hidden(true)
#
func _on_Area2D_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON and event.pressed == false:
	# Start dragging when the user presses the mouse button over the clickable area
		_picked_up()
