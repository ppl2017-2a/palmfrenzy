extends Control

onready var menu_utama = "res://scenes/main_menu.tscn"
onready var username_input = get_node("container_tombol_new/username_input")
onready var currentPlayer = get_node("container_tombol_continue/current_player")
onready var currentScreen = "awal"
onready var kontainer_player = get_node("container_tombol_continue/VBoxContainer")
var button
func _ready():
	for items in get_children():
		if items.has_node("cancel_button"):
			items.get_node("cancel_button").connect("pressed",self,"_on_cancel_button_pressed",[items.get_name()])
	#iterate player save:
	


func _on_exit_pressed():
	queue_free()
	get_tree().change_scene(menu_utama)

func _on_new_button_pressed():
	currentScreen = "container_tombol_new"
	get_node("container_tombol_utama").set_hidden(true);
	get_node("container_tombol_new").set_hidden(false);

func _on_continue_button_utama_pressed():
	currentScreen = "container_tombol_continue"
	get_node("container_tombol_utama").set_hidden(true);
	get_node("container_tombol_continue").set_hidden(false);
	for users in get_node("container_tombol_continue/VBoxContainer").get_children():
		if users extends Button:
			users.connect("pressed",self,"pilih_user",[users.get_text()])

func pilih_user(player):
	currentPlayer.set_text(player)

func _on_cancel_button_pressed(var target="awal"):
	get_node(target).set_hidden(true)
	get_node("container_tombol_utama").set_hidden(false)


func _on_delete_button_pressed():
	"container_tombol_continue/VBoxContainer/user1"
	
func _on_mainkan_button_pressed():
	# cek apakah username sesuai
	if(username_input.get_text().length() < 1 or username_input.get_text().begins_with(" ")):
		get_node("container_error").set_hidden(false)
		get_node("container_error/Label").set_text("Cannot use '%s' as your username" % username_input.get_text())
		get_node("container_tombol_new").set_hidden(true)
	else:
		object_state.set_nama(username_input.get_text())
		SaveManager.save(username_input.get_text(),{hello = "word"})
		queue_free()
		get_tree().change_scene("res://scenes/on_game.tscn")



func _on_continue_button_pressed():
	if SaveManager.load_game(currentPlayer.get_text()) == OK:
		SaveManager.load_game(currentPlayer.get_text())
		queue_free()
		get_tree().change_scene("res://scenes/on_game.tscn")
	else:
		get_node("container_error").set_hidden(false)
		get_node("container_tombol_continue").set_hidden(true);
		get_node("container_error/Label").set_text("Unable to load data for %s!" %currentPlayer.get_text())
	pass # replace with function body


func _on_ok_error_button_pressed():
	get_node("container_error").set_hidden(true)
	get_node(currentScreen).set_hidden(false)
	if get_node(currentScreen).has_node("username_input"):
		get_node("%s/username_input"%currentScreen).set_text("")
	elif get_node(currentScreen).has_node("current_player"):
		get_node("%s/current_player"%currentScreen).set_text("CHOOSE FROM LIST ABOVE")
