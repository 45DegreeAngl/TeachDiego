extends Object

var variable = null
const constant : int = 0

func _init() -> void:
	print("Hello, I am an Object.")
	
	print("I can hold any data type I'd like to :)")
	#print("Here is my property list : ",get_property_list())
	print("I can also connect signals, call functions and reference other objects")
	print("And I am communicating via the command prompt")
	
	print("I can await for signals")
	await_for_property_change()
	await await_finished
	print("See! I awaited for my waiting to be finished")
	
	print("Although, it is instantaneous since I cant sense time like you can\n")

signal await_finished
func await_for_property_change():
	await property_list_changed
	print("A property has changed")
	await_finished.emit()
