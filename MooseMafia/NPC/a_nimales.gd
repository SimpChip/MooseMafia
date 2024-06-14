extends CharacterBody2D


enum COW_STATE { IDLE, WAlK}


@export var move_speed : float = 20
@export var time_time : float = 0.2


@onready var sprite = $Sprite2D

@onready var timer = $Timer

var move_direction : Vector2 = Vector2.ZERO
var current_state : COW_STATE = COW_STATE.IDLE

func _ready():
	select_new_direction()
	
	
func _physics_process(_delta):
	velocity = move_direction * move_speed
	move_and_slide()
	
func select_new_direction():
	var random : float = randi_range(-2,1)
	if ( random > 0):
		move_direction = Vector2( randi_range(-1,1), randi_range(-1,1) )
	elif ( random < 0):
		move_direction = Vector2( 0,0)
		
	if (move_direction.x < 0 ):
		sprite.flip_h = true
	elif (move_direction.x > 0):
		sprite.flip_h = false
		
	timer.start(time_time)
	




func _on_timer_timeout():
	select_new_direction()
	pass # Replace with function body.
