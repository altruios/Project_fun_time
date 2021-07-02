extends Node

var n = 0.0
var count = 0

onready var steve_tscn = load("res://steve.tscn")
onready var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	
func make_steve():
	var node = steve_tscn.instance()
	node.set_name("node")
	node.set_position(Vector2(rng.randf_range(0,1000), 0)) 
	node.set_scale(Vector2(rng.randf_range(1,3),rng.randf_range(1,3)))
	add_child(node)

func _process(delta):
	if(Input.is_action_just_pressed("fire")):
		print("fired")
		make_steve()
		
