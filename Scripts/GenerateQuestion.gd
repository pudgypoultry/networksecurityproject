extends HBoxContainer

@export var questionBank : Node
@export var floatButtons : HBoxContainer
@export var floatText : TextEdit

func GenerateEasy():
	var newFloat = questionBank.GenerateEasyQuestion()
	floatButtons.SetImages(newFloat)
	TurnOffButtons()
	floatText.text = ""

func GenerateRandom():
	var newFloat = questionBank.GenerateDifficultQuestion()
	floatButtons.SetImages(newFloat)
	TurnOffButtons()
	floatText.text = ""

func GenerateEasyText():
	var newFloat = questionBank.GenerateEasyQuestion()
	floatText.text = var_to_str(newFloat)
	TurnOffButtons()
	floatButtons.SetImages(0.0)

func GenerateRandomText():
	var newFloat = questionBank.GenerateDifficultQuestion()
	floatText.text = var_to_str(newFloat)
	TurnOffButtons()
	floatButtons.SetImages(0.0)

func TurnOffButtons():
	for item in get_children():
		if item is Button:
			item.visible = false

func TurnOnButtons():
	for item in get_children():
		if item is Button:
			item.visible = true
