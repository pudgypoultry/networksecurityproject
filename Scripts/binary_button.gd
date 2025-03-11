extends Button

@export var zeroImage : Texture2D
@export var oneImage : Texture2D

# Called when the node enters the scene tree for the first time.
func _ready():
	toggle_mode = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if toggle_mode:
		icon = oneImage
	else:
		icon = zeroImage


func _on_pressed():
	toggle_mode = !toggle_mode
