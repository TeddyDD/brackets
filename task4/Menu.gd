extends Control

func _ready():
	get_tree().connect("files_dropped", self, "play_file")

func random_text() -> String:
	randomize()
	var f := File.new() as File
	f.open("res://data/langs.txt", File.READ)
	var lines := f.get_as_text()
	var arr := lines.split("\n", false)
	f.close()
	return arr[randi() % arr.size()]
	
func play_file(files, screen):
	var f := File.new() as File
	var err = f.open(files[0], File.READ)
	if err != 0:
		return
	var lines := f.get_as_text()
	var arr := lines.split("\n", false)
	f.close()
	global.text = arr[randi() % arr.size()]
	get_tree().change_scene("res://Main.tscn")	

func play():
	global.text = random_text()
	get_tree().change_scene("res://Main.tscn")
	
func stats():
	get_tree().change_scene("res://scenes/Stats.tscn")