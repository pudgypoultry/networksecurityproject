extends Node

func FloatToBinaryString(initial : float):
	# -17.5
	var returnArray = []
	for i in range(32):
		returnArray.append(0)
	
	var byteArray = PackedByteArray()
	for i in range(4):
		byteArray.append(0)
	
	# Convert to binary representation as bytes [0, 0, 192, 84]
	var i = 0
	byteArray.encode_float(0, initial)
	byteArray.reverse()
	# Reverse to match Big Endian as I want to read it [84, 192, 0, 0]
	
	for item in byteArray:
		var currentBinNumber = bin_string(item)
		
		for char in currentBinNumber:
			returnArray[i] = str_to_var(char)
			i += 1
		
		# [0, 1, 0, 1, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	
	return returnArray


func IntArrayToFloat(initial):
	var byteArray = PackedByteArray()
	for i in range(4):
		byteArray.append(0)
	
	var i = 0
	
	for k in range(4):
		for j in range(8):
			byteArray[k] = byteArray[k] << 1
			
			if initial[i] == 1:
				byteArray[k] += 1
			
			i += 1
	
	byteArray.reverse()
	return byteArray.decode_float(0)


func bin_string(n):
	var ret_str = ""
	while n > 0 or ret_str.length() < 8:
		# var_to_str converts a variable of any kind to a str represented
		# If I give it -17.5, this returns "-17.5"
		# n&1 200
		# 200 == 11001000 in binary
		# 11001000 
		#&       1
		#---------
		#        0
		# "" -> "0"
		# n = n >> 1
		# n = 1100100
		# ret_str = 1100100 & 1
		# "0" -> "00"
		# 1100100 >> 1 = 110010
		# "000"
		# 11001 & 1
		# "11001000"
		ret_str = var_to_str(n&1) + ret_str
		n = n >> 1
	return ret_str
