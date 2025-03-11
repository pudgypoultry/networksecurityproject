extends Button

@export var floatText : TextEdit
@export var floatButtons : HBoxContainer
@export var answerButtons : HBoxContainer

func _on_pressed():
	var floatString = floatText.text
	var floatNumber = str_to_var(floatString)
	if !(floatNumber is float) and !(floatNumber is int):
		floatText.text = "Enter a valid float!"
		return
	var floatTarget = floatButtons.ReadImages()
	if (floatNumber == floatTarget):
		floatText.text = "CORRECT!"
		answerButtons.TurnOnButtons()
	else:
		floatText.text = "Incorrect, try again!"
