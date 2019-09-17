extends Control

onready var input := $VBoxContainer/HBoxContainer/input
onready var display := $VBoxContainer/text
onready var label := $CenterContainer/countdown
onready var status := $VBoxContainer/HBoxContainer/Panel/CenterContainer/stats
onready var timer := $"CenterContainer/Countdown Timer"

var test = """It was extremely hot one day so some of us took a nap. Our schoolmaster scolded us. 'We went to dreamland to meet the ancient sages the same as Confucius did,' we explained. 'What was the message from those sages?' our schoolmaster demanded. One of us replied: 'We went to dreamland and met the sages and asked them if our schoolmaster came there every afternoon, but they said they had never seen any such fellow."""
var t : Text
var buffer = ""
var mistakes = 0
var _last_entered = ""

func _ready():
	input.grab_focus()
	t = Text.new(test)
	display.bbcode_text = t.bbcode

func _on_input_text_changed(new_text : String):
	compare(t, new_text)
	display.bbcode_text = t.bbcode
	update_status()
	if new_text.ends_with(" "):
		accept(t, new_text)
		
func compare(t : Text, new_text : String):
	var current = buffer + new_text
	var correct = 0
	var incorrect = 0
	var a = t.accepted
	for i in range(a, current.length()):
		if current[i] == t.text[i]:
			correct += 1
		else:
			incorrect = new_text.length() - correct
			if _last_entered.length() < new_text.length():
				mistakes += 1
			break
	t.correct = correct
	t.incorrect = incorrect
	_last_entered = new_text
	$debug.text = str(\
		t.accepted, " ",
		t.correct, " ",
		t.incorrect, " "
	)
	
	
func accept(t : Text, new_text : String):
	if t.incorrect != 0:
		return
	buffer += new_text
	t.accepted += new_text.length()
	input.text = ""
	
	
func update_status():
	status.text = "Mistakes: %s" % mistakes

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
	var correct := 2
	var incorrect := 2
	var accepted = 0
	var bbcode : String setget ,get_bbcode
	var size : int setget ,get_size

	func _init(text : String):
		self.text = text

	func get_size() -> int:
		return text.length()

	func get_bbcode() -> String:
		return "[color=#bada55]%s[/color][color=red]%s[/color]%s" \
		% [text.substr(0, accepted + correct),
		   text.substr(accepted + correct, incorrect),
		   text.substr(accepted + correct + incorrect, self.size)]