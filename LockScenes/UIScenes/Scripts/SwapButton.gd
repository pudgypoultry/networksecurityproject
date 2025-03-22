extends Button

@export var actionStack : ActionStack
@export var wheel1Box : SpinBox
@export var wheel2Box : SpinBox
var wheel1BoxLine : LineEdit
var wheel2BoxLine : LineEdit
var whichWheel1 : int
var whichWheel2 : int

func _ready():
	wheel1BoxLine = wheel1Box.get_line_edit()
	wheel2BoxLine = wheel2Box.get_line_edit()


func _on_pressed() -> void:
	self.disabled = true
	whichWheel1 = int(wheel1BoxLine.text)
	whichWheel2 = int(wheel2BoxLine.text)
	actionStack.Push(actionStack.ActionType.SWAP, whichWheel1, whichWheel2)
	await get_tree().create_timer(1).timeout
	self.disabled = false
