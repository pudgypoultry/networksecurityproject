extends Button

@export var complexityLine : SpinBox
@export var actionStacks : Array[ActionStack]

func _on_pressed() -> void:
	var complexity = int(complexityLine.get_line_edit().text)
	complexityLine.editable = false
	self.disabled = true
	for stack in actionStacks:
		stack.Demo(complexity)
