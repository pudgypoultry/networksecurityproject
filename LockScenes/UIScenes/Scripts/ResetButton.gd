extends Button

@export var keyText = ""
@export var plainText = "HELLO WORLD"
@export var keyTextBox : LineEdit
@export var plainTextTextBox : LineEdit
@export var fullContainer : MarginContainer


func _on_pressed() -> void:
	plainTextTextBox.text = plainText
	keyTextBox.text = ""
	plainTextTextBox.emit_signal("text_submitted", plainTextTextBox.text)
	await get_tree().create_timer(.5).timeout
	keyTextBox.text = keyText
	keyTextBox.emit_signal("text_submitted", keyTextBox.text)
