extends KinematicBody2D

var velocity = Vector2(0,0)
const speed=180
const gravity = 30
const jump_force = -750
func _physics_process(delta):
	velocity.y=velocity.y+gravity
	if(Input.is_action_pressed("left")):
		velocity.x=-speed
	if(Input.is_action_pressed("right")):
		velocity.x=speed
	if(Input.is_action_pressed("jump") and is_on_floor()):
		velocity.y=jump_force
	move_and_slide(velocity, Vector2.UP)
	velocity.x =lerp(velocity.x,0,0.1)
