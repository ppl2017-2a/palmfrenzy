extends Node2D
var shop_state = false
var air_kita = 0
var truk_kita = 0
var sawit_kita = 0
var pupuk_kita = 0
var pabrik_kita = 0
var pabrikAdv_kita = 0
var uang_kita = 0
onready var on_game_status = get_node("../")
func _ready():
	air_kita = on_game_status.get_air()
	truk_kita = on_game_status.get_truk_count()
	sawit_kita = on_game_status.get_sawit_count()
	pupuk_kita = on_game_status.get_pupuk()
	pabrik_kita = on_game_status.get_pabrik_count()
	pabrikAdv_kita = on_game_status.get_adv_pabrik_count()
	uang_kita = on_game_status.get_uang()
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
	get_node("../").add_child(toko)
	shop_state = true


func update_hud():
	air_kita = on_game_status.get_air()
	truk_kita = on_game_status.get_truk_count()
	sawit_kita = on_game_status.get_sawit_count()
	pupuk_kita = on_game_status.get_pupuk()
	pabrik_kita = on_game_status.get_pabrik_count()
	pabrikAdv_kita = on_game_status.get_adv_pabrik_count()
	uang_kita = on_game_status.get_uang()
	get_node("hud_tombol/txtUang").set_text(str(uang_kita))
	get_node("hud_tombol/txtAir").set_text(str(air_kita))
	get_node("hud_tombol/txtPupuk").set_text(str(pupuk_kita))
	get_node("hud_tombol/txtTruk").set_text(str(truk_kita))
	get_node("hud_tombol/txtSawit").set_text(str(sawit_kita))
	get_node("hud_tombol/txtPabrik").set_text(str(pabrik_kita))
	get_node("hud_tombol/txtPabrikAdv").set_text(str(pabrikAdv_kita))
	shop_state = false


func _on_pause_button_pressed():
	var pause = utils.get_main_node().find_node("pause_game")
	if pause:
		pause.show()
	get_tree().set_pause(true)
