extends Button

@export var actionStack : ActionStack


func _on_pressed() -> void:
	actionStack.Decrypt()
