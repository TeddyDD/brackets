extends Control

func _ready():
	pass

func random_text() -> String:
	randomize()
	var f := File.new() as File
	f.open("res://data/quotes.txt", File.READ)
	var lines := f.get_as_text()
	var arr := lines.split("\n", false)
	f.close()
	return arr[randi() % arr.size()]
	

func play():
	global.text = random_text()
	get_tree().change_scene("res://Main.tscn")
	
func stats():
	pass