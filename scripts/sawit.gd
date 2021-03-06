extends Sprite

onready var timer = get_node("Timer")
onready var my_id = get_instance_ID()
var my_key = ""
export (float, 0.0, 100.0, .1) var start_time = 0
export (float, 0.0, 100.0, .1) var end_time   = 100
export var critical_time = 30
export var need_time = 60
var kebutuhan = 7

func _ready():
	for key in get_parent().get_parent().player_property:
		if key.begins_with("sawit"):
			if get_parent().get_parent().player_property[key]["id"] == my_id:
				my_key = key
#	object_state.air_value = false
	timer.set_timer_process_mode(Timer.TIMER_PROCESS_FIXED)
	timer.set_wait_time(end_time - start_time)
	timer.set_one_shot(true)
	timer.connect("timeout", self, "gameover")
	get_node("ProgressBar").set_value(end_time)
#    add_child(timer)
	timer.start()

	set_fixed_process(true)

func gameover():
	get_parent().get_parent().set_sawit_count(-1,my_key)
	queue_free()

var t = 1
func _fixed_process(delta): # Print testing
	if(t >= 1):
		t -= 1
		print(timer.get_time_left())
		get_node("ProgressBar").set_value(timer.get_time_left())
#        set_value(timer.get_time_left())
		if(timer.get_time_left() < need_time and timer.get_time_left() > critical_time):
			if kebutuhan % 3 == 0:
				get_node("air").set_hidden(false)
			elif kebutuhan % 3 == 1:
				get_node("pupuk").set_hidden(false)
			else:
				if kebutuhan < 10:
					get_node("air").set_hidden(false)
				else:
					set_frame(4)
					get_node("panen").set_hidden(false)
		elif(timer.get_time_left() < critical_time):
			get_node("air").set_hidden(false)
			if kebutuhan < 10:
				self.set_frame(1)
			else:
				print("switched")
				set_frame(3)
	t += delta

const ADDITIONAL_TIME = 5.0
var clicked = 0

func _on_popup_pressed(): # Button for testing
# Must get time before stopping timer.
	var new_time = timer.get_time_left() + ADDITIONAL_TIME
#	set_value(new_time)
	kebutuhan+=1
	if kebutuhan < 10:
		set_frame(0)
	else:
		set_frame(2)
	timer.stop()
	timer.set_wait_time(new_time)
	timer.start()