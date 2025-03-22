extends Button

@export var actionStack : ActionStack
@export var wheelBox : SpinBox
@export var numBox : SpinBox
var wheelBoxLine : LineEdit
var numBoxLine : LineEdit
var whichWheel : int
var howFar : int

func _ready():
	wheelBoxLine = wheelBox.get_line_edit()
	numBoxLine = numBox.get_line_edit()


func _on_pressed() -> void:
	self.disabled = true
	whichWheel = int(wheelBoxLine.text)
	howFar = int(numBoxLine.text)
	actionStack.Push(actionStack.ActionType.ROTATE, whichWheel, howFar)
	await get_tree().create_timer(howFar * 0.2 + 0.2).timeout
	self.disabled = false
