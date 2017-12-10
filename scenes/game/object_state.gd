extends Node
# kita bisa menyiram atau tidak
var air_value = false
# variabel kepemilikan kita
var p_uang = 200
var p_air = 1
var p_pupuk = 30
var p_sawit = 1
var p_truk = 1
var p_pabrik = 1
var p_adv_pabrik = 0
# variabel untuk pengiriman
var truk_value = 5
# variabel untuk status pengiriman ke pabrik supaya bisa cetak koin
var truk_kirim_status = false
var pabrik_value = 3
var pabrik_nyawa = 100
var pabrik_received = false
var nama = null
var max_objects = [10,5,5,5]

func get_nama():
	return nama
	
func set_nama(_nama):
	nama = _nama

