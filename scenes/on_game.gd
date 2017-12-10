extends Node
onready var pabrik = load("res://scenes/game/pabrik.tscn")
onready var sawit = load("res://scenes/game/sawit.tscn")
onready var truk = load("res://scenes/game/truk.tscn")
onready var musiks = get_node("pause_game/musik")
var increased = false
var end = false


var player_property = {
	produksi = 0,
	hasil_panen = 0,
	uang = 200,
	pupuk = 10,
	air = 20,
	sawit0 = {
		id = 1,
		kebutuhan = 0,
		x = 130,
		y = 300
		},
	truk0 = {
		id = 2,
		x = 410,
		y = 350,
		truk_value = 0,
		max_truk_value = 5},
	pabrik0 = {
		id = 3,
		x = 870,
		y = 350,
		nyawa = 100,
		currentProduction = 0,
		maxProduction = 5}
}

func _ready():
	print("-----------------------------------")
	#instancing sawit
	for i in range(get_sawit_count()):
		var spawned_sawit = sawit.instance()
		if player_property.has("sawit%d"%i):
			spawned_sawit.set_pos(Vector2(player_property["sawit"+str(i)]["x"],player_property["sawit"+str(i)]["y"]))
			player_property["sawit"+str(i)]["id"] = spawned_sawit.get_instance_ID()
			utils.get_main_node().get_node("object_game").add_child(spawned_sawit)
			#print("scale value: ",spawned_sawit.get_scale()," ID: ",spawned_sawit.get_instance_ID())
	#instancing pabrik
	for i in range(get_pabrik_count()):
		var spawned_pabrik = pabrik.instance()
		if player_property.has("pabrik%d"%i):
			spawned_pabrik.set_pos(Vector2(player_property["pabrik"+str(i)]["x"],player_property["pabrik"+str(i)]["y"]))
			player_property["pabrik"+str(i)]["id"] = spawned_pabrik.get_instance_ID()
			utils.get_main_node().get_node("object_game").add_child(spawned_pabrik)
	#instancing truk
	for i in range(get_truk_count()):
		var spawned_truk = truk.instance()
		if player_property.has("truk%d"%i):
			spawned_truk.set_pos(Vector2(player_property["truk"+str(i)]["x"],player_property["truk"+str(i)]["y"]))
			player_property["truk"+str(i)]["id"] = spawned_truk.get_instance_ID()
			utils.get_main_node().get_node("object_game").add_child(spawned_truk)
	musiks.play_musik()
	set_process(true)

func _process(delta):
	update_state()
	if end:
		get_tree().set_pause(true)
		get_node("error_message").set_hidden(false)
		get_node("error_message/error_label").set_text("You dont have palm and money, gameover")
		get_node("error_message/ok_button").connect("pressed",self,"close_game")

func close_game():
	get_tree().set_pause(false)
	get_node("error_message").set_hidden(true)
	queue_free()
	get_tree().change_scene("res://scenes/main_menu.tscn")

func update_state():
	if get_uang() < 10 and get_sawit_count() == 0:
		end = true
		pass

func get_uang():
	return player_property["uang"]

func get_pupuk():
	return player_property["pupuk"]

func get_air():
	return player_property["air"]

func get_pabrik():
	var list_pabrik = {}
	for pabrik in player_property:
		if pabrik.begins_with("pabrik"):
			list_pabrik[pabrik] = player_property[pabrik]
	return list_pabrik

func get_pabrik_count():
	return get_pabrik().size()

func get_truk():
	var list_truk = {}
	for truk in player_property:
		if truk.begins_with("truk"):
			list_truk[truk] = player_property[truk]
	return list_truk

func get_truk_count():
	return get_truk().size()

func get_truk_value(var key="semua"):
	if player_property.has(key):
		return player_property[key]["truk_value"]
	else:
		var counts = 0
		for keys in player_property:
			if keys.begins_with("truk"):
				counts += player_property[keys]["truk_value"]
		return counts

func get_adv_pabrik():
	var list_pabrik_advanced = {}
	for adv_pabrik in player_property:
		if adv_pabrik.begins_with("adv_pabrik"):
			list_pabrik_advanced[adv_pabrik] = player_property[adv_pabrik]
	return list_pabrik_advanced

func get_adv_pabrik_count():
	return get_adv_pabrik().size()

func get_sawit():
	var list_sawit = {}
	for sawit in player_property:
		if sawit.begins_with("sawit"):
			list_sawit[sawit] = player_property[sawit]
	return list_sawit

func get_sawit_count():
	return get_sawit().size()

#saat membeli sawit dari shop menjalankan ini
func update_sawit(number,id):
	if increased:
		for i in range(number):
			var idx = get_sawit_count()
			if idx == 0:
				player_property["sawit%d"%idx] = {
					id = id,
					kebutuhan = 0,
					x = 130,
					y = 320}
			elif idx < 5 and idx > 0:
				player_property["sawit%d"%idx] = {
					id = id,
					kebutuhan = 0,
					x = 130,
					y = player_property["sawit%d"%(idx-1)]["y"] + 80}
			elif idx <= 6:
				player_property["sawit%d"%idx] = {
					id = id,
					kebutuhan = 0,
					x = 260,
					y = 320}
			elif idx > 6 and idx <= 10:
				player_property["sawit%d"%idx] = {
					id = id,
					kebutuhan = 0,
					x = 260,
					y = player_property["sawit%d"%(idx-1)]["y"] + 80}
			var new_sawit = sawit.instance()
			new_sawit.set_pos(Vector2(player_property["sawit%d"%idx]["x"],player_property["sawit%d"%idx]["y"]))
			player_property["sawit%d"%idx]["id"] = new_sawit.get_instance_ID()
			utils.get_main_node().get_node("object_game").add_child(new_sawit)
	else:
		player_property.erase(id)
		pass

#saat membeli sawit dari shop menjalankan ini
func set_sawit_count(number,id):
	if number > 0:
		increased = true
	else:
		increased = false
	update_sawit(number,id)

func set_air_count(number):
	player_property["air"] += number

func set_pupuk_count(number):
	player_property["pupuk"] += number

func set_uang_count(number):
	player_property["uang"] += number

#saat membeli pabrik dari shop menjalankan ini
func set_pabrik_count(number,id):
	if number > 0:
		increased = true
	else:
		increased = false
	update_pabrik(number,id)

#saat membeli truk dari shop menjalankan ini
func set_truk_count(number,id):
	if number > 0:
		increased = true
	else:
		increased = false
	update_truk(number,id)

#saat membeli pabrik dari shop menjalankan ini
func update_pabrik(number,id):
	if increased:
		for i in range(number):
			var idx = get_pabrik_count()
			player_property["pabrik%d"%idx] = {
				id = id,
				x = 870,
				y = player_property["pabrik%d"%(idx-1)]["y"] + 100,
				nyawa = 100,
				currentProduction = 0,
				maxProduction = 5}
			var new_pabrik = pabrik.instance()
			new_pabrik.set_pos(Vector2(player_property["pabrik%d"%idx]["x"],player_property["pabrik%d"%idx]["y"]))
			player_property["pabrik%d"%idx]["id"] = new_pabrik.get_instance_ID()
			utils.get_main_node().get_node("object_game").add_child(new_pabrik)
	else:
		pass
#saat membeli truk dari shop menjalankan ini
func update_truk(number,var id=8,var reset = false):
	if increased:
		for i in range(number):
			var idx = get_truk_count()
			player_property["truk%d"%idx] = {
				id = 35,
				x = 410,
				y = player_property["truk%d"%(idx-1)]["y"] + 100,
				truk_value = 0,
				max_truk_value = 5}
			var new_truk = truk.instance()
			new_truk.set_pos(Vector2(player_property["truk%d"%idx]["x"],player_property["truk%d"%idx]["y"]))
			player_property["truk%d"%idx]["id"] = new_truk.get_instance_ID()
			utils.get_main_node().get_node("object_game").add_child(new_truk)
	else:
		pass
	pass

func update_truk_value(number,var reset = false):
	var panen = get_hasil_panen()
	if reset:
		player_property["truk0"]["truk_value"] = 0
	else:
		if (get_truk_count() > 1 or get_hasil_panen() > 5):
			var sisapanen = get_hasil_panen()
			for i in range(get_truk_count()):
				if sisapanen - player_property["truk%d"%i]["truk_value"] >= 0 and player_property["truk%d"%i]["truk_value"] !=0 :
					player_property["truk%d"%i]["truk_value"] += (sisapanen - player_property["truk%d"%i]["truk_value"])
					sisapanen -= 5
				else:
					player_property["truk%d"%i]["truk_value"] += sisapanen
				pass
		else:
			player_property["truk0"]["truk_value"] += number

# pabrik terkait kapasitasnya berapa..
func update_pabrik_value(number,var id = "pabrik",var reset = false):
	var panen = get_hasil_panen()
	if reset:
		player_property[id]["currentProduction"] = number
	else:
		if get_pabrik_count() > 1 or get_produksi_pabrik() > 5:
			var sisaproduksi = get_produksi_pabrik()
			for i in range(get_pabrik_count()):
				player_property["pabrik%d"%i]["currentProduction"] += sisaproduksi % 5
				sisaproduksi -= 5
				pass
		else:
			player_property[id]["currentProduction"] += number

func get_pabrik_value(var id = "pabrikan"):
	if player_property.has(id):
		return player_property[id]["currentProduction"]
	else:
		return player_property["pabrik0"]["currentProduction"]

func get_hasil_panen():
	return player_property["hasil_panen"]

func get_produksi_pabrik():
	return player_property["produksi"]

func set_hasil_panen(var number,var reset =false):
	if reset:
		player_property["hasil_panen"] -= 5
	else:
		player_property["hasil_panen"] += number

#semua produksi di pabrik
func set_produksi_pabrik(var number,var reset =false):
	if reset:
		player_property["produksi"] = number
	else:
		player_property["produksi"] += number
	print("produksi hari ini:",player_property["produksi"])
	
func get_all_data():
	return player_property