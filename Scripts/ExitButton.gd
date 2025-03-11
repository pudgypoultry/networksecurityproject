extends HBoxContainer

@export var selectedArrow : TextureRect
@export var selectedImage : Texture2D
@export var notSelectedImage : Texture2D

var isMouseOver : bool

func _process(delta):
	if Input.is_action_just_pressed("confirm_click") and isMouseOver:
		get_tree().quit()

func _on_mouse_entered():
	isMouseOver = true
	selectedArrow.set_texture(selectedImage)

func _on_mouse_exited():
	isMouseOver = false
	selectedArrow.set_texture(notSelectedImage)
