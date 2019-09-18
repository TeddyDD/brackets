extends Node

# global state

var text : String
var result = {}
var results = []

const FILE = "user://data.json"

func read_save():
	var f = File.new()
	if not f.file_exists(FILE):
		return
	f.open(FILE, File.READ)
	results = parse_json(f.get_as_text())
	f.close()
	
func write_save():
	var f = File.new()
	f.open(FILE, File.WRITE)
	f.store_string(to_json(results))
	f.close()