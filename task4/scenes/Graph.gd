tool
extends Control

var points = []
export(Color) var bg = Color(0.067797, 0.057709, 0.242188)
export(Color) var fg = Color(0.059601, 0.699896, 0.847656)
export(float) var margin = 30

func _ready():
	connect("resized",self, "redraw")

func _process(delta):
	update()
	
func redraw():
	update()

func _draw():
	draw_rect(Rect2(Vector2(), rect_size), bg)
	var mn = points.min()
	var mx = points.max()
	var prev
	for i in range(points.size()):
		var p = points[i]
		var v = Vector2()
		v.y = range_lerp(p, mn, mx, rect_size.y - margin, 0 + margin)
		v.x = range_lerp(i, 0, points.size(), 0 + margin, rect_size.x - margin)
		if get_local_mouse_position().distance_squared_to(v) < 5:
			hint_tooltip = str(p)
		draw_circle(v, 3, fg)
		if prev:
			draw_line(v, prev, fg, 1, true)
		prev = v