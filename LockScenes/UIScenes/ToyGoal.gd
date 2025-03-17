extends HBoxContainer

@export var typeLines : VigenereUI
@export var neededPlainText : String
@export var neededKey : String
@export var currentTexture : TextureRect
@export var imageNo : Texture2D
@export var imageYes : Texture2D

var hasBeenDone : bool = false

enum StartingPoint {PLAINTEXT, KEY}

@export var whichFirst : StartingPoint

func _process(delta):
	WaitForAnswer()


func WaitForAnswer():
	# print(typeLines.keyText.text, " : ", neededPlainText, "\n", typeLines.plainText.text, " : ", neededPlainText)
	if !hasBeenDone && typeLines.keyText.text == neededKey && typeLines.plainText.text == neededPlainText:
		hasBeenDone = true
		FlipTexture()


func FlipTexture():
	currentTexture.texture = imageYes
