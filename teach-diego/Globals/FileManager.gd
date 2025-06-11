extends Node

const DEMO_PATH: String = "res://Demos/"

func scan_directory_iterative(start_path: String) -> Array:
	var files: Array = []
	var stack: Array = [start_path]  # Use a stack to manage directories

	while not stack.is_empty():
		var current_path = stack.pop_back()
		var dir = DirAccess.open(current_path)

		if dir:
			dir.list_dir_begin()
			var file_name = dir.get_next()

			while file_name != "":
				var file_path = current_path + "/" + file_name
				if dir.current_is_dir():
					stack.append(file_path)  # Push subdirectories to stack
				else:
					if !file_name.ends_with(".uid"):
						files.append(file_path)  # Store file paths
				file_name = dir.get_next()

			dir.list_dir_end()
		else:
			print("Failed to open directory: " + current_path)

	return files

func _ready():
	demo_files_in_path(DEMO_PATH)

func demo_files_in_path(path:String):
	var file_paths = scan_directory_iterative(path)
	print(file_paths)  # Displays the collected file paths
	for file:String in file_paths:
		if load(file):
			var temp = load(file)
			print(temp)
			if temp is Script:
				if temp.can_instantiate():
					var temp_node : Node = Node.new()
					temp_node.set_script(temp)
					add_child(temp_node)
					temp_node.call_deferred("queue_free")
			elif temp is Node:
				add_child(temp)
		else:
			var temp = FileAccess.open(file,FileAccess.READ_WRITE)
			
			print("This file (",file,") cannot be loaded by conventional means, so instead we are using FileAccess to classically read/write files")
			
			print("You can advance through the file by a pointer[like in C]")
			print("But don\'t worry about that because we can file.get_as_text()")
			var temp_as_text : String = temp.get_as_text()
			
			print("This is the text: \n",temp_as_text)
			
			print("You can open any file as text, but it might not always make sense")
			
			temp.close()
