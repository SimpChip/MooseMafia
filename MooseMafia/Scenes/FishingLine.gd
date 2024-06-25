extends Node2D

var points = []
var line_width = 1.0
var color = Color.WHITE

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_line_points(_points):
	points = _points

func _draw():
	global_position = Vector2.ZERO
	global_rotation = 0.0
	
	if (points.size() < 2):
		return
	draw_polyline(points, color, line_width)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	global_position = Vector2.ZERO
	global_rotation = 0.0
	
	queue_redraw()
