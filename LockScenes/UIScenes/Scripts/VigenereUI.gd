extends MarginContainer

class_name VigenereUI

@export var locks : LockArray
@export var keyText : LineEdit
@export var plainText : LineEdit


func _ready():
	locks.SetLockToWord(plainText.text)


func ResetWheel():
	locks.SetLockToWord(plainText.text)


func _on_plaintext_text_submitted(new_text: String) -> void:
	await get_tree().create_timer(.5).timeout
	keyText.emit_signal("text_submitted", keyText.text)
