extends Node

var EasyFloats : Array[float] = [0.0, 0.25, 0.5, 0.75, 0.125, 0.375, 0.25, 0.75, 0.0625, 0.1875, 0.3125, 0.4375, 0.5625, 0.6875, 0.8125, 0.9375]

func GenerateEasyQuestion() -> float:
	var rng = RandomNumberGenerator.new()
	var randomArrayIndex = rng.randi_range(0, EasyFloats.size() - 1)
	var randomAddInt = rng.randi_range(-1024, 1024)
	return randomAddInt + EasyFloats[randomArrayIndex]

func GenerateDifficultQuestion() -> float:
	var rng = RandomNumberGenerator.new()
	return randf()
