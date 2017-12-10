extends Sprite
export var current_production = 0
#var current_production = object_state.pabrik_value
export (float, 0.0, 100.0, .1) var start_time = 0
export (float, 0.0, 100.0, .1) var end_time   = 25
export var nyawa_value = 100
var production_speed = 200
var can_production = false
var sedang_produksi = false
var stok_masuk = object_state.pabrik_received #boolean
export var pabrik_capacity = 5
onready var timer = get_node("Timer")
onready var kapasitas = get_node("kapasitas")
onready var nyawa = get_node("nyawa")
onready var properti = get_parent().get_parent()
var my_key

func _ready():
	for keys in properti.player_property:
		if keys.begins_with("pabrik"):
			if properti.player_property[keys]["id"] == get_instance_ID():
				my_key = keys
				current_production = properti.get_pabrik_value(my_key)
	
	print("posisi pabrik: ",get_global_pos())
	kapasitas.set_value(current_production)
	nyawa.set_value(nyawa_value)
	timer.set_timer_process_mode(Timer.TIMER_PROCESS_FIXED)
	timer.set_wait_time(end_time - start_time)
	timer.set_one_shot(true)
	timer.connect("timeout", self, "_pasca_produksi")
	set_fixed_process(true)

func _pasca_produksi():
	nyawa_value -= 20
	current_production -= 1
	utils.get_main_node().update_pabrik_value(current_production,my_key,true)
	utils.get_main_node().set_produksi_pabrik(-1,false)
#	object_state.pabrik_value = current_production
	kapasitas.set_value(current_production)
	nyawa.set_value(nyawa_value)

func maintened():
	nyawa_value = 100
	nyawa.set_value(nyawa_value)

func _fixed_process(delta):
	_cek_maintenance()
	if stok_masuk:
		update_produksi()
		stok_masuk = false
		object_state.pabrik_received = stok_masuk
	update_produksi()

func update_produksi():
#	current_production = object_state.pabrik_value
	current_production = utils.get_main_node().get_produksi_pabrik()
	kapasitas.set_value(current_production)
	if current_production > 0:
#		set_fixed_process(false)
		if sedang_produksi == false:
			produksi()

func _cek_maintenance():
	if nyawa_value < 50:
		production_speed = 100
		end_time = 30
		if nyawa_value < 30:
			production_speed = 50
			end_time = 35
		get_node("pabrik_mt").set_hidden(false)

var t =1
func _process(delta):
	if can_production:
		if t >= 1:
			t -= 1
			print("sedang produksi...,", timer.get_time_left())
			if timer.get_time_left() < 1:
				timer.emit_signal("timeout")
				print("produksi sukses..,status produksi: ",sedang_produksi)
				sedang_produksi = false
				# stok kosong
				if current_production < 1:
					print("tidak ada stok, berhenti produksi..")
					can_production = false
					sedang_produksi = false
					timer.stop()
					set_process(false)
				# masih ada stok, lanjut..
				else:
					timer.stop()
					timer.set_wait_time(end_time - start_time)
					set_fixed_process(true)
				get_node("pabrik_uang").set_hidden(false)
				get_node("pabrik_uang").set_fixed_process(true)
		t+=delta
	pass

func get_production_speed():
	return production_speed

func produksi():
	if current_production > 0:
		timer.start()
		can_production = true
		sedang_produksi = true
		set_process(true)
	else:
		timer.stop()
		can_production = false
		current_production = 0
		update_pabrik_value(current_production,true)
#		object_state.pabrik_value = current_production
		timer.set_wait_time(end_time - start_time)
	print("stok pabrik: ",current_production)

#func increase_production_counts():
#	# kalau masih belum penuh, bisa produksi..
#	if current_production < pabrik_capacity:
#		current_production+=1
#		object_state.pabrik_value = current_production
#	# kalau sudah penuh, lempar error  !
#	else:
#		get_parent().get_node("error_message").set_hidden(true)
#		get_parent().get_node("error_message/error_label").set_text("Factory is FULL!")
#	return