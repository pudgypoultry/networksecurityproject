extends Button

@export var complexityLine : SpinBox
@export var actionStacks : Array[ActionStack]

func _on_pressed() -> void:
	for stack in actionStacks:
		stack.Demo(int(complexityLine.get_line_edit().text))
