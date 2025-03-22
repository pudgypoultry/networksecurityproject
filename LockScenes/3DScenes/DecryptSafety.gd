extends Button

@export var waitForDecrypt : ActionStack
var hasNotBeenPressed = true

func _ready():
	self.disabled = true

func _on_pressed() -> void:
	self.disabled = true
	hasNotBeenPressed = false

func _process(delta):
	if hasNotBeenPressed:
		if waitForDecrypt.doneWithEncryption && self.disabled:
			self.disabled = false
