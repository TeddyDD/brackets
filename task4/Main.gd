extends Control

onready var input := $VBoxContainer/input
onready var display := $VBoxContainer/text
onready var label := $CenterContainer/countdown
onready var timer := $"CenterContainer/Countdown Timer"

func _ready():
	input.grab_focus()

func _on_input_text_changed(new_text : String):
	pass # Replace with function body.

# Start countdown

func _on_Countdown_Timer_timeout():
	label.text = str(timer.times)

func _on_Countdown_Timer_last_timeout():
	label.visible = false
