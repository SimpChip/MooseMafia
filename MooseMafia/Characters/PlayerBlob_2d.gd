extends CharacterBody2D

@export var move_speed : float = 100
@export var starting_direction : Vector2 = Vector2(0,1)

@onready var animation_tree = $AnimationTree

func _ready():
	animation_tree.set("parameters/Idle/blend_position", starting_direction )
	update_animation_parameter(starting_direction)

func _physics_process(_delta):
	# Get input direction
	
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	update_animation_parameter(input_direction)
	# Update velocity
	velocity = input_direction * move_speed
	
	
	# Move and Slide function uses velocity of character body to move character on map
	move_and_slide()
	
func update_animation_parameter( move_input : Vector2):
	if(move_input != Vector2.ZERO):
		print(move_input)
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)
