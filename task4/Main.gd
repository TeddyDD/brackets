extends Control

onready var input := $VBoxContainer/HBoxContainer/input
onready var display := $VBoxContainer/text
onready var label := $CenterContainer/countdown
onready var status := $VBoxContainer/HBoxContainer/Panel/CenterContainer/stats
onready var timer := $"CenterContainer/Countdown Timer"

# internal variables 

var task_text = "some text"
var t : Text
var buffer = ""
var mistakes = 0
var _last_entered = ""
var done = false setget set_done
var time

func _ready():
	task_text = global.text
#	input.editable = false
	t = Text.new(task_text)
	display.bbcode_text = t.bbcode
	time = OS.get_system_time_msecs()
	
func set_done(value):
	done = value
	if done:
		global.result = {
			time = (OS.get_system_time_msecs() - time) / 1000.0,
			chars = t.text.length(),
			mistakes = mistakes
		}
		get_tree().change_scene("res://scenes/Stats.tscn")

func _on_input_text_changed(new_text : String):
	compare(t, new_text)
	display.bbcode_text = t.bbcode
	if new_text.ends_with(" "):
		accept(t, new_text)
	update_status()
		
func compare(t : Text, new_text : String):
	var current = buffer + new_text
	if current.length() > t.text.length():
		current = current.substr(0, t.text.length())
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
		t.accepted, " acc ",
		t.correct, " corr ",
		t.incorrect, " incor ",
		t.text.length(), " len ",
		done, " ",
		"Buf ", buffer, " "
	)

# mark part of text as accepted and remove it from
# input line
func accept(t : Text, new_text : String):
	if t.incorrect != 0:
		return
	buffer += new_text
	t.accepted += new_text.length()
	input.text = ""
	# this is gamedev, hacks are allowed :P
	if t.accepted >= t.size: 
		self.done = true
	compare(t, "")
	
func update_status():
	var completed = min(round(float(t.accepted) / t.text.length() * 100.0), 100.0)
	status.text = "Completed: %s%% Mistakes: %s" % [str(completed), mistakes]

# Start countdown

func _on_Countdown_Timer_timeout():
	label.text = str(timer.times)

func _on_Countdown_Timer_last_timeout():
	label.visible = false
	input.editable = true
	input.grab_focus()	

# Wrapper for string that outputs BBCode
# YAY BBCode. Like in 2001 on web forums :D
class Text:
	# GDScript is dynamically typed but has
	# optional static type checking (like Python)
	var text : String
	var correct := 0
	var incorrect := 0
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