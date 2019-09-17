extends Control

onready var input := $VBoxContainer/HBoxContainer/input
onready var display := $VBoxContainer/text
onready var label := $CenterContainer/countdown
onready var timer := $"CenterContainer/Countdown Timer"

var test = """
"It was extremely hot one day so some of us took a nap. Our schoolmaster scolded us. 'We went to dreamland to meet the ancient sages the same as Confucius did,' we explained. 'What was the message from those sages?' our schoolmaster demanded. One of us replied: 'We went to dreamland and met the sages and asked them if our schoolmaster came there every afternoon, but they said they had never seen any such fellow.'"
"""
var t : Text

func _ready():
	input.grab_focus()
	t = Text.new(test)
	display.bbcode_text = t.bbcode

func _on_input_text_changed(new_text : String):
	pass

# Start countdown

func _on_Countdown_Timer_timeout():
	label.text = str(timer.times)

func _on_Countdown_Timer_last_timeout():
	label.visible = false

# Wrapper for string that outputs BBCode
# YAY BBCode. Like in 2001 on web forums :D
class Text:
	# GDScript is dynamically typed but has
	# optional static type checking (like Python)
	var text : String
	var correct := 12
	var incorrect := 2
	var bbcode : String setget ,get_bbcode
	var size : int setget ,get_size
	
	func _init(text : String):
		self.text = text
		
	func get_size() -> int:
		return text.length()
	
	func get_bbcode() -> String:
		return "[color=#bada55]%s[/color][color=red]%s[/color]%s" \
		% [text.substr(0, correct),
		   text.substr(correct, incorrect),
		   text.substr(correct + incorrect, self.size)]