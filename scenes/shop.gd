extends Node2D
export var H_PUPUK = 2
export var H_AIR = 4
export var H_SAWIT = 20
export var H_TRUK = 100
export var H_PABRIK = 300
export var H_PABRIKADV = 500

# barang [qty , subtotal]
var pupuk=[0,0]
var air=[0,0]
var sawit=[0,0]
var truk=[0,0]
var pabrik=[0,0]
var pabrikAdv=[0,0]
var total_harga=0
var can_buy = true
onready var l_total = "Total = 0"
onready var properti = get_node("../")
func _ready():
	set_fixed_process(true)
	get_node("background/Label").set_text(str(properti.get_uang()))
	get_node("tombols/harga").set_text(l_total)
	for components in get_node("tombols/shop_container").get_children():
		if components.has_node("SpinBox"):
			components.get_node("SpinBox").connect("value_changed",self,"_on_value_changed",[components.get_name()])

func _fixed_process(delta):
	if !can_buy:
		reset_value()

func _on_value_changed(value,parent):
	l_total = "Total = "
	if parent == "pupuk":
		pupuk[0] = value
		pupuk[1] = value * H_PUPUK
	elif parent == "air":
		air[0] = value
		air[1] = value * H_AIR
	elif parent == "sawit":
		sawit[0] = value
		sawit[1] = value * H_SAWIT
	elif parent == "truk":
		truk[0] = value
		truk[1] = value * H_TRUK
	elif parent == "pabrik":
		pabrik[0] = value
		pabrik[1] = value * H_PABRIK
	else:
		pabrikAdv[0] = value
		pabrikAdv[1]= value * H_PABRIKADV
		
	total_harga = pupuk[1] + air[1] + sawit[1] + truk[1] + pabrik[1] + pabrikAdv[1]
	get_node("tombols/harga").set_text(l_total + str(total_harga))


func _on_leave():
	queue_free()
	get_tree().set_pause(false)

func reset_value():
	if can_buy:
		properti.set_uang_count(-total_harga)
		properti.set_air_count(air[0])
		properti.set_sawit_count(sawit[0],1)
		properti.set_pupuk_count(pupuk[0])
		properti.set_pabrik_count(pabrik[0],1)
		properti.set_truk_count(truk[0],1)
#		object_state.p_truk += truk[0]
#		object_state.p_pabrik += pabrik[0]
#		object_state.p_adv_pabrik += pabrikAdv[0]
		
	pupuk=[0,0]
	air=[0,0]
	sawit=[0,0]
	truk=[0,0]
	pabrik=[0,0]
	pabrikAdv=[0,0]
	for components in get_node("tombols/shop_container").get_children():
		if components.has_node("SpinBox"):
			components.get_node("SpinBox").set_value(0)
	can_buy = true

func _on_buy_button_pressed():
	if(properti.get_uang() < total_harga or sawit[0] > object_state.max_objects[0] or truk[0] > object_state.max_objects[1]
	or pabrik[0] > object_state.max_objects[2] or pabrikAdv[0] > object_state.max_objects[3]):
		can_buy = false
		get_node("konfirmasi/popup_konfirmasi").show()
	else:
		reset_value()
		get_node("background/Label").set_text(str(properti.get_uang()))
		

