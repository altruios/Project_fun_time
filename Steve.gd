extends KinematicBody2D

var velocity = Vector2(0,0)
var speed=21
var gravity = 30
var jump_force = -350

func _physics_process(delta):
	velocity.y=velocity.y+gravity
	if (Input.is_action_pressed("left")):
		velocity.x-=speed
	if (Input.is_action_pressed("right")):
		velocity.x+=speed
	if (is_on_floor()):
		velocity.y=jump_force
	
	move_and_slide(velocity, Vector2.UP)
	velocity.x *= 0.95
