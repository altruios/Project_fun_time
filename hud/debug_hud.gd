extends CanvasLayer
var steve_count=0
var bob_count=0
var tim_count=0
var health = 0
var bob_pos = Vector2(20,18)
var robot_size = Vector2(30,40)
var tim_pos = Vector2(20,60)
var steve_pos = Vector2(20,110)
var all_size = Vector2(30,130)


func _ready():

	$steve_count.text="#" +String(steve_count) + " adds "+String(steve_count*1)+" health"
	$bob_count.text = "#" +String(bob_count)+ " :"+String(bob_count*2)+" health"
	$tim_count.text ="#" + String(tim_count)+ " :"+String(tim_count*3)+" health"
	$health.text = "total health: "+String(health)

func _on_camera_update(x,y):
	$camera.text="camera pos = x :"+String(x)+" ::: y:"+String(y);

	
func _on_make_robot(type):
	match(type):
		"Bob":
			bob_count=bob_count+1
		"Steve":
			steve_count=steve_count+1
		"Tim":
			tim_count=tim_count+1
	_ready()
	
func _on_change_heatlh(amount):
	health=amount
	_ready()


func _on_select_robot(name):

	match name:
		"all":
			$selected_robots.set_position(bob_pos);
		"bob":
			$selected_robots.set_position(bob_pos);
		"tim":
			$selected_robots.set_position(tim_pos);
		"steve":
			$selected_robots.set_position(steve_pos);
	if(name=="all"):
		$selected_robots.set_size(all_size);
	else:
		$selected_robots.set_size(robot_size);
	
			
		
			
