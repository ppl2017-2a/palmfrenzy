extends Node2D
var shop_state = false
var air_kita = object_state.p_air
var truk_kita = object_state.p_truk
var sawit_kita = object_state.p_sawit
var pupuk_kita = object_state.p_pupuk
var pabrik_kita = object_state.p_pabrik
var pabrikAdv_kita = object_state.p_pabrikAdv
var uang_kita = object_state.p_uang
func _ready():
	set_fixed_process(true)
	get_node("hud_tombol/txtUang").set_text(str(uang_kita))
	get_node("hud_tombol/txtAir").set_text(str(air_kita))
	get_node("hud_tombol/txtPupuk").set_text(str(pupuk_kita))
	get_node("hud_tombol/txtTruk").set_text(str(truk_kita))
	get_node("hud_tombol/txtSawit").set_text(str(sawit_kita))
	get_node("hud_tombol/txtPabrik").set_text(str(pabrik_kita))
	get_node("hud_tombol/txtPabrikAdv").set_text(str(pabrikAdv_kita))

func _fixed_process(delta):
	update_hud()

func _on_shopButton_pressed():
	get_tree().set_pause(true)
	var toko = preload("res://scenes/shop.tscn").instance()
	toko.set_z(99)
	get_node("../../").add_child(toko)
	shop_state = true


func update_hud():
	air_kita = object_state.p_air
	truk_kita = object_state.p_truk
	sawit_kita = object_state.p_sawit
	pupuk_kita = object_state.p_pupuk
	pabrik_kita = object_state.p_pabrik
	pabrikAdv_kita = object_state.p_pabrikAdv
	uang_kita = object_state.p_uang
	get_node("hud_tombol/txtUang").set_text(str(uang_kita))
	get_node("hud_tombol/txtAir").set_text(str(air_kita))
	get_node("hud_tombol/txtPupuk").set_text(str(pupuk_kita))
	get_node("hud_tombol/txtTruk").set_text(str(truk_kita))
	get_node("hud_tombol/txtSawit").set_text(str(sawit_kita))
	get_node("hud_tombol/txtPabrik").set_text(str(pabrik_kita))
	get_node("hud_tombol/txtPabrikAdv").set_text(str(pabrikAdv_kita))
	shop_state = false


func _on_pause_button_pressed():
	get_tree().set_pause(true)
