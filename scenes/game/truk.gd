extends Sprite
# bisa gerak kah ?
var can_move = false
# stok saat ini berapa di truk
var current_stock = object_state.truk_value
# stok seharusnya
export var max_stock = 5
# speed truk
export var max_speed = 100
# posisi truk
var truk_awal = Vector2()
var is_truk_kirim = false
var current_truk_pos = Vector2()
onready var pabrik = get_parent().get_node("pabrik")

func _ready():
	set_frame(0)
	get_node("ProgressBar").set_value(current_stock)
	truk_awal = get_global_pos()
	print("TRUK AWAL: ",truk_awal)
	print("PABRIK AWAL: ",pabrik.get_global_pos())
	set_fixed_process(true)
	set_process(false)

func _fixed_process(delta):
	_update_stok()
	if current_stock == 5:
		set_frame(1)
		get_node("truk_kirim").set_hidden(false)

func _process(delta):
	#gerak ke kanan
	if is_truk_kirim:
		if get_global_pos().x < pabrik.get_global_pos().x:
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
			object_state.truk_kirim_status = false
			set_process(false)
			set_fixed_process(true)

func set_is_truk_kirim(status):
	is_truk_kirim = status

func _update_stok():
	current_stock = object_state.truk_value
	get_node("ProgressBar").set_value(current_stock)