extends Button

@export var plainText : LineEdit
@export var startingText : String

func _on_pressed() -> void:
	plainText.text = startingText
	plainText.emit_signal("text_submitted", plainText.text)
