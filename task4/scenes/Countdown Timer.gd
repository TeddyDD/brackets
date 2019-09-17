extends Timer

# Number of restarts
export(int) var times = 3
signal last_timeout

func _ready():
	run()

func run():
	one_shot = false
	start(1)
	while times >= 0:
		yield(self, "timeout") # coroutines FTW
		times -= 1
	stop()
	emit_signal("last_timeout")