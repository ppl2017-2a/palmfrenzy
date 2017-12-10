extends Sprite

onready var timer = get_node("Timer")
var picked_up = false
var timeout= false
func _ready():
	timer.set_timer_process_mode(Timer.TIMER_PROCESS_FIXED)
	timer.set_wait_time(15)
	timer.set_one_shot(true)
	timer.connect("timeout", self, "hilang")
	set_fixed_process(true)

func hilang():
	timeout = true
	_picked_up()

func _fixed_process(delta):
	if !is_hidden():
		timeout = false
		print("yeahh...")
		timer.start()
		set_process(true)
		set_fixed_process(false)

func _process(delta):
#	if picked_up:
#		picked_up = false
#		get_node("AnimationPlayer").stop(true)
#		set_process(false)
#		timer.stop()
#	else:
#	print("waktu koin :",timer.get_time_left())
	if timer.get_time_left() < 6:
		if !get_node("AnimationPlayer").is_playing():
			get_node("AnimationPlayer").play("blink")

func _picked_up():
	if !timeout:
#		picked_up = true
		if get_parent().get_production_speed() < 30:
			utils.get_main_node().set_uang_count(40)
#			object_state.p_uang+=40
		elif get_parent().get_production_speed() > 30 and get_parent().get_production_speed() < 50:
			utils.get_main_node().set_uang_count(60)
#			object_state.p_uang+=60
		else:
			utils.get_main_node().set_uang_count(80)
#			object_state.p_uang+=80
		print("Koin picked up")
	get_node("AnimationPlayer").stop(true)
	awal()
	set_process(false)
	timer.stop()
	set_hidden(true)
	
func awal():
	get_node("AnimationPlayer").seek(0,true)
	set_opacity(1)

func _on_Area2D_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON and event.pressed == false:
	# Start dragging when the user presses the mouse button over the clickable area
		_picked_up()
