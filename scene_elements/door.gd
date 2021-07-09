extends StaticBody2D
var is_open = false;
var id=0; #need to generate ids...

func _on_unlock(id):
	if(self.id==id):
		is_open = !is_open;


func _ready():
	pass # Replace with function body.
