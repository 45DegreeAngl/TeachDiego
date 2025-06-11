extends SyntaxHighlighter

# Define keyword colors
var keyword_colors = {
	"func": Color(1, 0.5, 0),
	"var": Color(0.2, 0.8, 1),
	"if": Color(0.8, 0.2, 0.5),
	"return": Color(1, 0, 0),
	"for": Color(0.6, 0.3, 0.8),
}

var comment_color = Color(0.3, 0.8, 0.3)
var number_color = Color(0, 0.6, 1)

func _get_line_syntax_highlighting(line_number: int) -> Dictionary:
	var result = {}
	var text_edit = get_text_edit()

	if not text_edit:
		return result

	var line_text = text_edit.get_line(line_number)
	var words = line_text.split(" ")

	var index = 0
	for word in words:
		var length = word.length()
		var format_data = {}

		# Check for keywords
		if word in keyword_colors:
			format_data["color"] = keyword_colors[word]

		# Check for numbers
		elif word.is_valid_int() or word.is_valid_float():
			format_data["color"] = number_color

		# Check for comments
		elif word.begins_with("#"):
			format_data["color"] = comment_color

		result[index] = format_data
		index += length + 1  # Adjust for spacing

	return result
