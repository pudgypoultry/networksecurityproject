extends Node

@export var imageArray : Array[Button]
@export var byteImageOptions : Array[Texture2D]
@export var byteTextArray : Array[TextureRect]

# Called when the node enters the scene tree for the first time.
func _ready():
	for item in get_children():
		imageArray.append(item)
	SetImages(0.0)

func _process(delta):
	UpdateNibbles()

func SetImages(floatToConvert : float):
	var floatConverterScript = load("res://Scripts/FloatToBinary.gd")
	var floatConverterNode = floatConverterScript.new()
	var intArray = floatConverterNode.FloatToBinaryString(floatToConvert)
	for i in range(imageArray.size()):
		if intArray[i] == 0:
			imageArray[i].toggle_mode = false
		else:
			imageArray[i].toggle_mode = true
	
	
	# print_debug("Float Converted: ", floatToConvert)

func ReadImages() -> float:
	var floatConverterScript = load("res://Scripts/FloatToBinary.gd")
	var floatConverterNode = floatConverterScript.new()
	var returnArray : Array[int] = []
	for image in imageArray:
		if image.toggle_mode == false:
			returnArray.append(0)
		if image.toggle_mode == true:
			returnArray.append(1)
	var returnFloat = floatConverterNode.IntArrayToFloat(returnArray)
	return returnFloat

func GetByteFromIntArray(currentArray) -> int:
	var currentFactor = 8
	var runningTotal = 0
	for i in range(4):
		if currentArray[i]:
			runningTotal += currentFactor
		currentFactor = currentFactor / 2
	return runningTotal

func UpdateNibbles():
	# Consider making this only act on pressing buttons within FloatButtons since checking every update is excessive
	var floatConverterScript = load("res://Scripts/FloatToBinary.gd")
	var floatConverterNode = floatConverterScript.new()
	
	var intArray = floatConverterNode.FloatToBinaryString(ReadImages())
	
	for i in range(8):
		var currentArray = []
		var currentPosition = 4 * i
		for j in range(4):
			currentArray.append(intArray[currentPosition + j])
		byteTextArray[i].set_texture(byteImageOptions[GetByteFromIntArray(currentArray)])
