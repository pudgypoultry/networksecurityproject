extends Button

@export_category("Lines")
@export var keyText : LineEdit
@export var plainText : LineEdit

@export_category("Starting Point")
@export var startingKey : String
@export var startingPlain : String


func _on_pressed() -> void:
	plainText.text = startingPlain
	keyText.text = ""
	plainText.emit_signal("text_submitted", plainText.text)
	await get_tree().create_timer(.5).timeout
	keyText.text = startingKey
	keyText.emit_signal("text_submitted", keyText.text)
