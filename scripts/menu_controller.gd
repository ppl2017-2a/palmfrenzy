extends Control
onready var play_scene = "res://scenes/play_menu.tscn"
onready var tween = get_node("tween")

func _ready():
	pass

func _on_exit_button_pressed():
	_targets("exit_container");

func _on_ensiklopedia_button_pressed():
	_targets("ensiklopedia_container");

func playAction():
#	queue_free();
	get_tree().change_scene(play_scene);

func aboutAction():
	_targets("about_container");

func _on_no_button_pressed():
	_targets("start");

func _on_exit_yes_button_pressed():
	get_tree().quit();

func _targets(var screen = "start"):
	var target_coordinates = Vector2(0, 0)
	if has_node(screen):
		target_coordinates = get_node(screen).get_pos()
		get_node("buttons").set_hidden(true);
	else:
		get_node("buttons").set_hidden(false);
	var current_coordinates = get_pos()
	var distance = current_coordinates.distance_to(target_coordinates)
	var time = distance/1200
	if time > 0:
		tween.interpolate_property(self, "rect/pos", current_coordinates, -target_coordinates, time, Tween.TRANS_EXPO, Tween.EASE_OUT, 0)
		tween.start()

