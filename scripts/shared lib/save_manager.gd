extends "file_manager.gd"
func _ready():
	pass

func save(_player,var data = {}):
	var nama = _player
	var save_path = "res://"+nama+".json"
	var save_dict = {}
	var nodes_to_save = get_tree().get_nodes_in_group("persistent")
	save_dict[nama] = {}
	for keys in data:
		save_dict["%s"%nama][keys] = data[keys]
#		save_dict["player"][node.get_path()] = node.get_state()
	print(save_dict)
	write_file(save_path,save_dict.to_json())

func load_game(_player):
	var file = File.new()
	var save_path = "res://"+_player+".json"
	if not file.file_exists(save_path):
		print("Oops, save file does not exist.")
		return
	file.open(save_path,File.READ)

	var data = {}
	data.parse_json(open_file(save_path).get_as_text())
	for node_path in data.keys():
		var node_data = data[node_path]
		get_node(node_path).load_state(node_data)
	
func delete(_player):
	var save_path = "res://"+_player+".json"
	open_file(save_path)
	
func load_data():
	pass