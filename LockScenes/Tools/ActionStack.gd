extends Node

class_name ActionStack

enum ActionType {SWAP, ROTATE}
enum WhichLock {LEFT, RIGHT, COMBINED}
@export var locks : LockArray
@export var movementTime = 1.0
var actionStack = []
var currentTween1 : Tween
var currentTween2 : Tween
@export var stackTracker : Label
@export var proceedButton : Button
@export var timer : Timer
@export var side : WhichLock
@export var startingWord : String
var doneWithEncryption = false
var doneWithDecryption = false


func _ready():
	locks.SetLockToWord(startingWord)
	# Demo(10)
	#await get_tree().create_timer(6).timeout
	#Push(ActionType.ROTATE, 0, 1)
	#await get_tree().create_timer(movementTime).timeout
	#Push(ActionType.ROTATE, 1, 1)
	#await get_tree().create_timer(movementTime).timeout
	#Push(ActionType.ROTATE, 2, 1)
	#await get_tree().create_timer(movementTime).timeout
	#Push(ActionType.ROTATE, 3, 1)
	#await get_tree().create_timer(movementTime).timeout
	#Push(ActionType.ROTATE, 4, 1)
	#await get_tree().create_timer(movementTime).timeout
	#Push(ActionType.SWAP, 0, 6)
	#await get_tree().create_timer(movementTime).timeout
	#Push(ActionType.SWAP, 1, 7)
	#await get_tree().create_timer(movementTime).timeout
	#Push(ActionType.SWAP, 2, 8)
	#await get_tree().create_timer(movementTime).timeout
	#Push(ActionType.SWAP, 3, 9)
	#await get_tree().create_timer(movementTime).timeout
	#Push(ActionType.SWAP, 4, 10)
	#await get_tree().create_timer(2).timeout
	#Decrypt()

func _process(delta):
	if stackTracker:
		stackTracker.text = str(len(actionStack))


func Push(type : ActionType, x : int, y : int):
	match type:
		ActionType.SWAP:
			Execute(type, x, y)
			actionStack.append([type, x, y])
		ActionType.ROTATE:
			Execute(type, x, y)
			actionStack.append([type, x, -y])


func Pop():
	if len(actionStack) > 0:
		var ret = actionStack.pop_back()
		return ret
	else:
		return [null, null, null]


func Execute(type : ActionType, x : int, y : int):
	match type:
		ActionType.SWAP:
			var lock1 = locks.lockArray[x]
			var lock2 = locks.lockArray[y]
			var firstPosition = lock1.position
			var secondPosition = lock2.position
			
			currentTween1 = TweenPosition(lock1, currentTween1, firstPosition + Vector3(0, 1, 0), movementTime/4)
			currentTween2 = TweenPosition(lock2, currentTween2, secondPosition + Vector3(0, -1, 0), movementTime/4)
			await currentTween1.finished
			await currentTween2.finished
			
			currentTween1 = TweenPosition(lock1, currentTween1, secondPosition + Vector3(0, 1, 0), movementTime/2)
			currentTween2 = TweenPosition(lock2, currentTween2, firstPosition + Vector3(0, -1, 0), movementTime/2)
			await currentTween1.finished
			await currentTween2.finished
			
			currentTween1 = TweenPosition(lock1, currentTween1, secondPosition, movementTime/4)
			currentTween2 = TweenPosition(lock2, currentTween2, firstPosition, movementTime/4)
			await currentTween1.finished
			await currentTween2.finished
			
			var tempLock = locks.lockArray[x]
			locks.lockArray[x] = locks.lockArray[y]
			locks.lockArray[y] = tempLock
			
		ActionType.ROTATE:
			if y > 0:
				for i in range(y):
					locks.TickLockUp(x)
					await get_tree().create_timer(locks.lockArray[0].tickTime * 2).timeout
			else:
				for i in range(-y):
					locks.TickLockDown(x)
					await get_tree().create_timer(locks.lockArray[0].tickTime * 2).timeout


func Decrypt():
	var makeButtonVisible = false
	if len(actionStack) > 9:
		makeButtonVisible = true
	var lastAction = [ActionType.ROTATE, 0, 0]
	var currentAction = lastAction
	while len(actionStack) > 0:
		currentAction = Pop()
		Execute(currentAction[0], currentAction[1], currentAction[2])
		match currentAction[0]:
			ActionType.ROTATE:
				timer.wait_time = abs(currentAction[2]) * 0.2 + 0.4
			ActionType.SWAP:
				timer.wait_time = movementTime + 0.4
		timer.start()
		await timer.timeout
		lastAction = currentAction
	print(name, " is done")
	doneWithDecryption = true
	if makeButtonVisible:
		proceedButton.visible = true


func TweenPosition(whatObject, whichTween, desiredPosition, desiredLength):
	whichTween = create_tween().bind_node(whatObject)
	whichTween.set_trans(Tween.TRANS_SINE)
	whichTween.set_ease(Tween.EASE_IN_OUT)
	whichTween.tween_property(whatObject, "position", desiredPosition, desiredLength)
	return whichTween


func Demo(complexity : int):
	timer.wait_time = 1
	timer.start()
	await timer.timeout
	if side == WhichLock.COMBINED:
		for i in range(complexity):
			var firstWheel = randi_range(0, 10)
			var secondWheel = randi_range(11, 21)
			Push(ActionType.SWAP, firstWheel, secondWheel)
			timer.wait_time = movementTime + 0.2
			timer.start()
			await timer.timeout
	else:
		for i in range(complexity):
			# Rotate
			if i % 2 == 0:
				var whichWheel = randi_range(0, 10)
				var howFar = randi_range(1, 10)
				Push(ActionType.ROTATE, whichWheel, howFar)
				timer.wait_time = howFar * 0.3 + 0.3
				timer.start()
			# Swap
			else:
				var firstWheel = randi_range(0, 10)
				var secondWheel = randi_range(0, 10)
				while secondWheel == firstWheel:
					secondWheel = randi_range(0, 10)
				Push(ActionType.SWAP, firstWheel, secondWheel)
				timer.wait_time = movementTime + 0.3
				timer.start()
			await timer.timeout
	print(name, " is done encrypting")
	doneWithEncryption = true
