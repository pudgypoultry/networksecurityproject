extends HBoxContainer

@export var keyTracker : KeyTracker
@export var plainTextLine : LineEdit
@export var neededPlainText : String
@export var neededCount : int
@export var currentTexture : TextureRect
@export var imageNo : Texture2D
@export var imageYes : Texture2D
@export var proceedButton : Button

var hasBeenDone : bool = false

enum StartingPoint {PLAINTEXT, KEY}

@export var whichFirst : StartingPoint

func _process(delta):
	WaitForAnswer()


func WaitForAnswer():
	#print(keyTracker.currentCount, " : ", neededCount)
	if !hasBeenDone && plainTextLine.text == neededPlainText && keyTracker.currentCount == neededCount:
		hasBeenDone = true
		FlipTexture()


func FlipTexture():
	currentTexture.texture = imageYes
	proceedButton.visible = true
