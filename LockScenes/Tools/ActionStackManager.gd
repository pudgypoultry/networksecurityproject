extends Node

@export var leftStack : ActionStack
@export var rightStack : ActionStack
@export var combinedStack : ActionStack
@export var leftLock : LockArray
@export var rightLock : LockArray
@export var combinedLock : LockArray
@export var complexityLine : SpinBox

var swappedForEncryption = false
var swappedForDecryption = false



# Called when the node enters the scene tree for the first time.
func SwapLocks():
	await get_tree().create_timer(0.3).timeout
	var temp = leftLock.get_position().y
	leftLock.set_position(Vector3(leftLock.position.x, combinedLock.position.y, leftLock.position.z))
	rightLock.set_position(Vector3(rightLock.position.x, combinedLock.position.y, rightLock.position.z))
	combinedLock.set_position(Vector3(combinedLock.position.x, temp, combinedLock.position.z))



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if leftStack.doneWithEncryption && rightStack.doneWithEncryption && !swappedForEncryption:
		swappedForEncryption = true
		var wordForCombinedLock = ""
		wordForCombinedLock += leftLock.GetCurrentWord()
		wordForCombinedLock += rightLock.GetCurrentWord()
		combinedLock.visible = true
		combinedLock.SetLockToWord(wordForCombinedLock)
		# await get_tree().create_timer(0.1).timeout
		SwapLocks()
		leftLock.visible = false
		rightLock.visible = false
		# await get_tree().create_timer(0.1).timeout
		combinedStack.Demo(int(complexityLine.get_line_edit().text))
		
	if combinedStack.doneWithDecryption && !swappedForDecryption:
		swappedForDecryption = true
		leftLock.visible = true
		rightLock.visible = true
		# await get_tree().create_timer(0.1).timeout
		SwapLocks()
		# await get_tree().create_timer(0.1).timeout
		combinedLock.visible = false
		leftStack.Decrypt()
		rightStack.Decrypt()
