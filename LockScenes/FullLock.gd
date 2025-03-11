extends Node3D

class_name LockArray

@export var lockArray : Array[LetterWheel]
@export var clickTime = 0.05
var canChange = true
var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ "
var currentWord : String


func SetLockToWord(word : String):
	currentWord = word.to_upper()
	for lockNum in range(lockArray.size()):
		if IsAlphabetical(word[lockNum]):
			lockArray[lockNum].SetWheelToLetter(word[lockNum].to_upper())
		elif word[lockNum] == " ":
			lockArray[lockNum].SetWheelToLetter(" ")
		lockArray[lockNum].ResetLetter()


func IsAlphabetical(word : String):
	var regex = RegEx.new()
	regex.compile("[A-Za-z]")
	var result = regex.search(word)
	if result:
		return true
	else:
		return false


func IsSpace(word : String):
	var regex = RegEx.new()
	regex.compile(" ")
	var result = regex.search(word)
	if result:
		return true
	else:
		return false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func TickLockUp(lock : int):
	lockArray[lock].TickUp()


func TickLockDown(lock : int):
	lockArray[lock].TickDown()


func TickAllUp():
	StopInput()
	for lock in lockArray:
		lock.ResetLetter()
		await get_tree().create_timer(clickTime).timeout
		print("-> ", lock.currentLetter)
		if !IsSpace(lock.currentLetter):
			lock.TickUp()
	print(lockArray[0].currentTick, " : ", lockArray[0].currentLetter)


func TickAllDown():
	StopInput()
	for lock in lockArray:
		lock.ResetLetter()
		await get_tree().create_timer(clickTime).timeout
		print(IsAlphabetical(lock.currentLetter))
		if !IsSpace(lock.currentLetter):
			lock.TickDown()
	print(lockArray[0].currentTick, " : ", lockArray[0].currentLetter)


func KeyToDistances(key : String):
	var listOfNewDistances = []
	for letter in key:
		letter = letter.to_upper()
		var currentPosition = alphabet.find(letter)
		listOfNewDistances.append(currentPosition)
		print("Building list: ", listOfNewDistances)
	
	var listOfCurrentDistances = []
	for letter in currentWord:
		if IsAlphabetical(letter):
			var currentPosition = alphabet.find(letter)
			listOfCurrentDistances.append(currentPosition)
		else:
			listOfCurrentDistances.append(-1)
	
	var newWordPositions = []
	var counter = 0
	print("Finished List of New Distanced: ", listOfNewDistances)
	print("Finished List of Old Distanced: ", listOfCurrentDistances)
	
	for pos in range(currentWord.length()):
		if listOfCurrentDistances[pos] == -1:
			newWordPositions.append(-1)
		else:
			counter = counter % (listOfNewDistances.size())
			newWordPositions.append((listOfCurrentDistances[pos] + listOfNewDistances[counter]) % 26)
			counter += 1
			print("=====")
			print("	OldLetter: ", listOfCurrentDistances[pos])
			print("	NewLetter: ", newWordPositions[pos])
			print("=====")
	
	print("Finished List of New Distanced: ", listOfNewDistances)
	print("Finished List of Old Distanced: ", listOfCurrentDistances)
	print("Finished Final List of Letters: ", newWordPositions)
	var newWord = ""
	for item in newWordPositions:
		print("Current Item: ", item, ":", alphabet[item])
		newWord += alphabet[item]
	
	print("New Word: ", newWord)
	return newWord


func SetNewKey(newKey : String):
	if !newKey.is_empty():
		var newWord = KeyToDistances(newKey)
		var oldWord = currentWord
		SetLockToWord(newWord)
		currentWord = oldWord
	else:
		SetLockToWord(currentWord)


func _on_up_button_pressed() -> void:
	if canChange:
		TickAllUp()


func _on_down_button_pressed() -> void:
	if canChange:
		TickAllDown()


func StopInput():
	var totalTime = lockArray.size() * clickTime
	canChange = false
	await get_tree().create_timer(.8).timeout
	canChange = true


func _on_plaintext_text_changed(new_text: String) -> void:
	if new_text.length() < lockArray.size():
		new_text += "           "
	SetLockToWord(new_text)


func _on_keytext_text_submitted(new_text: String) -> void:
	SetNewKey(new_text)
