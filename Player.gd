extends RigidBody2D

func _process(delta):
	if (Input.is_action_pressed("left")):
		velocity.x += -spee
	if (Input.is_action_pressed("right")):
		velocity.x += speed
