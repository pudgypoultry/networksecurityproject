extends Button

@export var floatText : TextEdit
@export var floatButtons : HBoxContainer
@export var answerButtons : HBoxContainer

func _on_pressed():
	var floatString = floatText.text
	var floatTarget = str_to_var(floatString)
	var floatNumber = floatButtons.ReadImages()
	if (floatNumber == floatTarget):
		floatText.text = "CORRECT!"
		answerButtons.TurnOnButtons()
