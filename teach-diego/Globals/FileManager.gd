extends Node

const DIRECTORY_PATH: String = "res://Console Scripts/"

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
	var file_paths = scan_directory_iterative(DIRECTORY_PATH)
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
					
					
		
