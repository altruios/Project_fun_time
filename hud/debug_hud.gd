extends CanvasLayer
var steve_count=0
var bob_count=0
var tim_count=0
var health = 0
func _ready():
	print("ready function called")
	$steve_count.text="#" +String(steve_count) + " adds "+String(steve_count*1)+" health"
	$bob_count.text = "#" +String(bob_count)+ " :"+String(bob_count*2)+" health"
	$tim_count.text ="#" + String(tim_count)+ " :"+String(tim_count*3)+" health"
	$health.text = "total health: "+String(health)
	
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
