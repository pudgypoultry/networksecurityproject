extends Button

@export var actionStack : ActionStack

func _process(delta):
	if self.disabled:
		if len(actionStack.actionStack) == 0:
			await get_tree().create_timer(1).timeout
			self.disabled = false

func _on_pressed() -> void:
	self.disabled = true
	actionStack.Decrypt()
