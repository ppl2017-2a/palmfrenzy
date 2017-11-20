extends Node2D
const H_PUPUK = 2
const H_AIR = 4
const H_SAWIT = 20
const H_TRUK = 100
const H_PABRIK = 300
const H_PABRIKADV = 500

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
onready var l_uang = "Your Coin ="
var uang_kita = object_state.p_uang
func _ready():
	set_fixed_process(true)
	get_node("background/Label").set_text(l_uang+str(uang_kita))
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
		uang_kita-=total_harga
		object_state.p_uang = uang_kita
		object_state.p_air += air[0]
		object_state.p_sawit += sawit[0]
		object_state.p_pupuk += pupuk[0]
		object_state.p_truk += truk[0]
		object_state.p_pabrik += pabrik[0]
		object_state.p_pabrikAdv += pabrikAdv[0]
		
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
	if(uang_kita < total_harga):
		can_buy = false
		get_node("konfirmasi/popup_konfirmasi").show()
	else:
		reset_value()
		get_node("background/Label").set_text(l_uang+str(uang_kita))
		

