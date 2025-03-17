extends Node

class_name ActionStack

enum ActionType {SWAP, ROTATE}

@export var locks : LockArray
@export var movementTime = 1.0
var actionStack = []
var currentTween1 : Tween
var currentTween2 : Tween
@export var timer : Timer


func _ready():
	locks.SetLockToWord("Hello World")
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
	var lastAction = [ActionType.ROTATE, 0, 0]
	var currentAction = lastAction
	while len(actionStack) > 0:
		match currentAction[0]:
			ActionType.ROTATE:
				timer.wait_time = currentAction[2] * 0.1 + 0.2
				timer.start()
			ActionType.SWAP:
				timer.wait_time = movementTime + 0.2
				timer.start()
		await timer.timeout
		currentAction = Pop()
		Execute(currentAction[0], currentAction[1], currentAction[2])
		lastAction = currentAction


func TweenPosition(whatObject, whichTween, desiredPosition, desiredLength):
	whichTween = create_tween().bind_node(whatObject)
	whichTween.set_trans(Tween.TRANS_SINE)
	whichTween.set_ease(Tween.EASE_IN_OUT)
	whichTween.tween_property(whatObject, "position", desiredPosition, desiredLength)
	return whichTween
