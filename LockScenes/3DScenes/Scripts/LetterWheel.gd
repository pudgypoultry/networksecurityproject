extends Node3D # Includes all properties of the Node3D class
# If you want to know more about this, press F1 while in the godot editor and search for "Node3D" for the documentation

class_name LetterWheel


@export var rotationAmount : float = 2*PI/27 # Constant of rotation
@export var numCharacters = 26 # Maximum number of rotations before back at start
var currentTick = 0 # Track how many times the wheel has been ticked
var originalRotation # Save original rotation so it's easy to return to
var testTimer = 0 # Debug value used to watch the tweens work
var currentTween # Value for the tween in TweenRotation to use so I don't remake it every time
var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ "
var currentLetter = "A"
var tickTime = 0.1
var tween

func _ready():
	originalRotation = rotation # save original rotation upon start of scene


func SetWheelToLetter(letter : String):
	rotation = originalRotation
	currentLetter = "A"
	currentTick = 0
	var targetTick = alphabet.find(letter)
	var rotationTarget
	if currentTick > targetTick:
		rotationTarget = -rotationAmount * (currentTick - targetTick)
	elif currentTick < targetTick:
		rotationTarget = -rotationAmount * (targetTick - currentTick)
	else:
		rotationTarget = 0
	
	tween = TweenRotation(rotation + Vector3(0, 0, rotationTarget), tickTime)
	await tween.finished
	
	currentTick = targetTick
	currentLetter = alphabet[currentTick]


func TickUp(tickingOver = false):
	# Tick the wheel up to the next character
	tween = TweenRotation(rotation + Vector3(0, 0, -rotationAmount), tickTime)
	await tween.finished
	currentTick += 1
	if tickingOver:
		currentTick = 0
		currentLetter = "A"
	else:
		if currentTick < numCharacters:
			currentLetter = alphabet[currentTick]
	if currentTick == numCharacters:
		TickUp(true)


func TickDown(tickingOver = false):
	# Tick the wheel down to the last character
	tween = TweenRotation(rotation + Vector3(0, 0, rotationAmount), tickTime)
	await tween.finished
	currentTick -= 1
	if tickingOver:
		currentTick = 25
		currentLetter = "Z"
	else:
		currentLetter = alphabet[currentTick]
	if fposmod(currentTick, numCharacters + 1) == numCharacters:
		TickDown(true)


func TweenRotation(desiredRotation, desiredLength):
	# Create a "tween" an object that manages interpolation from one set of a transform's values to another
	currentTween = create_tween().bind_node(self)
	currentTween.set_trans(Tween.TRANS_SINE)
	currentTween.set_ease(Tween.EASE_IN_OUT)
	currentTween.tween_property(self, "rotation", desiredRotation, desiredLength)
	return currentTween


func ResetLetter():
	currentLetter = alphabet[currentTick]
