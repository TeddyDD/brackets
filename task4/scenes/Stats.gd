extends Control

func _ready():
	global.read_save()
	var result = global.result
	if result:
		global.results.append(result)
	global.write_save()
	if global.results.empty():
		return
	result = global.results[-1]
	$PanelContainer/hbox/HBoxContainer/result.bbcode_text = \
	"Recent game\n[color=#0fb2d8]CPM: %s[/color]\n[color=#d80f93]Mistakes %d[/color]"\
	% [result.chars / (result.time / 60), result.mistakes]
	global.result = null
	
	var cpms = []
	var mistakes = []
	for e in global.results:
		mistakes.append(e.mistakes)
		cpms.append(e.chars / (e.time / 60))
	$PanelContainer/hbox/HBoxContainer/VBoxContainer/cpm.points = cpms
	$PanelContainer/hbox/HBoxContainer/VBoxContainer/mistakes.points = mistakes

func _on_menu_pressed():
	get_tree().change_scene("res://Menu.tscn")
