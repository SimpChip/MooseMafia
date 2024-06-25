extends Node2D

var GRAVITY := 125

var start_pos : Vector2
var end_pos : Vector2

var launch_velocity
var launch_angle
var cast_direction: int
var cast_length

var is_casting : bool = false

var elapsed_cast_time: float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_casting:
		cast_throw(delta)
	
	$Sprite2D.position = $"../../Camera2D".get_screen_center_position() + Vector2(15, -10)
	

func cast_throw(delta):
	if elapsed_cast_time > cast_length:
		return
	
	elapsed_cast_time += delta
	
	var x_offset = launch_velocity * elapsed_cast_time * cos(launch_angle)
	if (cast_direction == -1):
		x_offset *= -1
	var y_offset = launch_velocity * elapsed_cast_time * sin(launch_angle) - 0.5 * GRAVITY * pow(elapsed_cast_time, 2)
	y_offset *= -1
	
	print("START: " + str(start_pos))
	$"../Bobber".position = start_pos + Vector2(x_offset, y_offset)
	
	draw_fishing_line()


func throw(_start_pos, _end_pos):
	start_pos = _start_pos
	end_pos = _end_pos
	
	elapsed_cast_time = 0
	
	#launch_velocity = sqrt(GRAVITY * (end_pos.y + sqrt(pow(end_pos.y, 2) + pow())))
	var target_end = end_pos - start_pos
	
	if (target_end.x > 0):
		cast_direction = 1
	else:
		cast_direction = -1
		
	target_end.x = abs(target_end.x)
	target_end.y *= -1
	
	launch_velocity = sqrt(pow(target_end.x, 2) + pow(target_end.y, 2))
	launch_angle = atan(target_end.y / target_end.x)
	
	cast_length = target_end.x / (launch_velocity * cos(launch_angle))
	
	print("Starting new throw: ")
	print("START POS: " + str(start_pos))
	print("END POS: " + str(end_pos))
	print("VELOCITY: " + str(launch_velocity))
	print("ANGLE: " + str(launch_angle))
	
	is_casting = true

func draw_fishing_line():
	const _step = 0.5
	
	var _cast_direction
	var _initial_pos = $Sprite2D/TopRod.global_position
	var _target_pos = $"../Bobber".global_position
	if (_target_pos.x > 0):
		_cast_direction = 1
	else:
		_cast_direction = -1
		
	var _line_points = []
	
	var _initial_point = _initial_pos - _target_pos
	var _end_point = Vector2(0,0)
	
	_line_points.append($"../Bobber".global_position)
	
	var a = pow(pow(_initial_point.x, 2) / _initial_point.y, -1)
	
	var distance_traveled = 0.0
	while (abs(distance_traveled) < abs(_target_pos.x - _initial_pos.x)):
		
		var y = a * pow(distance_traveled, 2)
		_line_points.append(Vector2(distance_traveled, y) + _target_pos)

		distance_traveled += _step * -cast_direction
		
	_line_points[_line_points.size() - 1] = start_pos
	$"../FishingLine".update_line_points(_line_points)
	
