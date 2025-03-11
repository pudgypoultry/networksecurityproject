extends Button

@export var floatText : TextEdit
@export var floatButtons : HBoxContainer

func _on_pressed():
	var floatString = floatText.text
	var floatNumber = str_to_var(floatString)
	if !(floatNumber is float) and !(floatNumber is int):
		floatText.text = "Enter a valid float!"
		return
	floatButtons.SetImages(floatNumber)
