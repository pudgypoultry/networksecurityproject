extends Label

class_name KeyTracker

var currentCount : int = 0
var canAct = true
@export var timer : Timer

# TODO: CREATE STATIC TIMER RATHER THAN USING NEW ONES EVERY TIME
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if currentCount < 0:
		currentCount = 26 + currentCount
	if currentCount == 26:
		currentCount = 0
	self.text = str(currentCount)


func _on_key_up_pressed() -> void:
	if canAct:
		canAct = false
		currentCount += 1
		timer.set_wait_time(.8)
		timer.start()
	await timer.timeout
	canAct = true


func _on_key_down_pressed() -> void:
	if canAct:
		canAct = false
		currentCount -= 1
		timer.set_wait_time(.8)
		timer.start()
	await timer.timeout
	canAct = true


func _on_plaintext_text_submitted(new_text: String) -> void:
	currentCount = 0
