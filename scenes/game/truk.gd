extends Sprite
# bisa gerak kah ?
var can_move = false
# stok seharusnya
export var max_stock = 5
# speed truk
export var max_speed = 200
# posisi truk
var truk_awal = Vector2()
var is_truk_kirim = false
var current_truk_pos = Vector2()
onready var pabrik = get_parent().get_node("pabrik")
onready var properti = get_parent().get_parent()
var my_key
# stok saat ini berapa di truk
var current_stock = 0

func _ready():
	for keys in properti.player_property:
		if keys.begins_with("truk"):
			if properti.player_property[keys]["id"] == get_instance_ID():
				my_key = keys
				current_stock = properti.get_truk_value(my_key)
	set_frame(0)
	get_node("ProgressBar").set_value(current_stock)
	truk_awal = get_global_pos()
#	print("TRUK AWAL: ",truk_awal)
#	print("PABRIK AWAL: ",pabrik.get_global_pos())
	set_fixed_process(true)
	set_process(false)

func _fixed_process(delta):
	_update_stok()
	if current_stock % 5==0 and current_stock != 0:
		set_frame(1)
#		print("sebenere ada berapa sih??.. ",utils.get_main_node().get_produksi_pabrik())
#		print("panennya berapa??.. ",utils.get_main_node().get_hasil_panen())
		get_node("truk_kirim").set_hidden(false)

func _process(delta):
	#gerak ke kanan
	if is_truk_kirim:
		if get_global_pos().x < pabrik.get_global_pos().x :
			set_flip_h(false)
			current_truk_pos = Vector2(max_speed,0)
			set_global_pos(get_global_pos() + current_truk_pos * delta)
		else:
			is_truk_kirim = false
	#gerak ke kiri
	else:
		if get_global_pos().x > truk_awal.x:
			set_flip_h(true)
			set_frame(0)
			get_node("ProgressBar").set_value(0)
			current_truk_pos = Vector2(-max_speed,0)
			set_global_pos(get_global_pos() + current_truk_pos * delta)
		else:
			set_global_pos(truk_awal)
			set_flip_h(false)
			if object_state.truk_kirim_status:
				utils.get_main_node().set_produksi_pabrik(1)
#				object_state.pabrik_value += 1
				pabrik.update_produksi()
				
			object_state.truk_kirim_status = false
			set_process(false)
			set_fixed_process(true)

func set_is_truk_kirim(status):
	is_truk_kirim = status

func _update_stok():
	current_stock = properti.get_truk_value(my_key)
	get_node("ProgressBar").set_value(current_stock)