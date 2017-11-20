extends Control

onready var menu_utama = "res://scenes/main_menu.tscn"
onready var currentScreen = "awal"
func _ready():
	for items in get_children():
		if items.has_node("cancel_button"):
			items.get_node("cancel_button").connect("pressed",self,"_on_cancel_button_pressed",[items.get_name()])
		if items.has_node("play_button"):
			get_tree().change_scene("res://scenes/on_game.tscn")


func _on_exit_pressed():
	queue_free()
	get_tree().change_scene(menu_utama)

func _on_new_button_pressed():
	get_node("container_tombol_utama").set_hidden(true);
	get_node("container_tombol_new").set_hidden(false);

func _on_continue_button_utama_pressed():
	get_node("container_tombol_utama").set_hidden(true);
	get_node("container_tombol_continue").set_hidden(false);


func _on_cancel_button_pressed(var target="awal"):
	get_node(target).set_hidden(true)
	get_node("container_tombol_utama").set_hidden(false)


func _on_delete_button_pressed():
	pass # replace with function body

func _on_mainkan_button_pressed():
	get_tree().change_scene("res://scenes/on_game.tscn")
