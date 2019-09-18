extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var result = global.result
	global.result = null
	$PanelContainer/CenterContainer/result.text = "CPM: %s\nMistakes %d"\
	% [result.chars / (result.time / 60), result.mistakes]
	global.read_save()
	global.results.append(result)
	global.write_save()


func _on_menu_pressed():
	get_tree().change_scene("res://Menu.tscn")
