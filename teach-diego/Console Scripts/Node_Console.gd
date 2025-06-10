extends Node

func _ready()->void:
	print("Hello, I am a node!")
	
	print("I am a step up from an object, as I integrate the scene tree, even my function for when I am READY is different")

	print("Although I am technically still an object, the integration into the scene tree allows me to do many things")
	
	print("Such as call \'get_tree\'")
	
	print(get_tree(),"\nThis is the scene tree!\nIt holds everything that can be seen and interacted with.")
	
	print("It holds all nodes that are currently running in the processes and calling functions")
