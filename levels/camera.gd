extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal send_pos(x,y)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	emit_signal("send_pos", self.position.x,self.position.y)
