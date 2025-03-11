extends MarginContainer

@export var locks : LockArray
@export var textBox : LineEdit
@export var keyUpButton : Button
@export var keyDownButton : Button


func _ready():
	pass
	locks.SetLockToWord(textBox.text)
