extends Button

@export var floatText : TextEdit
@export var floatButtons : HBoxContainer

func _on_pressed():
	var floatNumber = floatButtons.ReadImages()
	var floatString = var_to_str(floatNumber)
	floatText.text = floatString
