extends CharacterBody2D

@export var move_speed : float = 100

@export var starting_direction : Vector2 = Vector2(0,1)


@onready var animation_tree: AnimationTree = $AnimationTree

func _ready():
	animation_tree.active = true
	

func _physics_process(_delta):
	
	
	var input_direction  = Input.get_vector("left", "right", "up", "down").normalized()
	
	update_animation_parameters(input_direction)
	
	if input_direction:
		
		velocity = input_direction * move_speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()
	
	animation_tree["parameters/conditions/is_idle"] = velocity == Vector2.ZERO
	animation_tree["parameters/conditions/is_moving"] = velocity != Vector2.ZERO


func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree["parameters/Idle/blend_position"] = move_input
		animation_tree["parameters/Walk/blend_position"] = move_input
	
	print(animation_tree["parameters/Idle/blend_position"] )

	


		
	
