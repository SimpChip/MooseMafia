extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if event is InputEventMouseButton:
		if event.get_button_index() == MOUSE_BUTTON_LEFT and event.pressed:
			var top_left = $"../Camera2D".get_screen_center_position() - (get_viewport_rect().size / 2)
			
			var start: Vector2 = $FishingRod/Sprite2D/TopRod.global_position
			var end: Vector2 = top_left+event.position
			$FishingRod.throw(start, end)
