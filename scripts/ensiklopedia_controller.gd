extends ReferenceFrame
onready var gambar = [
"res://assets/ensiklopedia/tampilan encyclopedia 1.png",
"res://assets/ensiklopedia/tampilan encyclopedia 2.png",
"res://assets/ensiklopedia/tampilan encyclopedia 3.png",
"res://assets/ensiklopedia/tampilan encyclopedia 4.png",
"res://assets/ensiklopedia/tampilan encyclopedia 5.png",
"res://assets/ensiklopedia/tampilan encyclopedia 6.png"
]
onready var currentFrame = 0
onready var kontenEnsiklopedia = get_node("Sprite")
onready var tombolNext = get_node("next")
onready var tombolPrev = get_node("prev")
const MAX_FRAME = 5
const MIN_FRAME = 0

func _ready():
	currentFrame = 0
	_target(currentFrame)

func nextAction():
	currentFrame += 1
	_target(currentFrame)

func prevAction():
	currentFrame -= 1
	_target(currentFrame)
	
func _target(var currentFrame = 0):
	if currentFrame == MIN_FRAME:
		tombolPrev.set_hidden(true)
	elif currentFrame == MAX_FRAME:
		tombolNext.set_hidden(true)
	else:
		tombolNext.set_hidden(false)
		tombolPrev.set_hidden(false)
	kontenEnsiklopedia.get_texture().load(gambar[currentFrame])

