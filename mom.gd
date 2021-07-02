extends Node

var count = 0
var center = Vector2(0.0, 0.0)
var jitter = 25
var width = 100

onready var steve_tscn = load("res://steve.tscn")
onready var rng = RandomNumberGenerator.new()
onready var camera = get_node("../camera")

func _ready():
	rng.randomize()
	for _i in range(180):
		make_steve()
	
func make_steve():
	var node = steve_tscn.instance()
	node.set_name("node")
	var offset = Vector2(rng.randf_range(-100, 100), rng.randf_range(-100, 100))
	node.set_position(center + offset) 
	var scale = Vector2(rng.randf_range(1.5,2.5),rng.randf_range(1.5,2.5))
	node.set_scale(scale)
	add_child(node)

func _process(_delta):
	var pos = Vector2(0,0)
	var children = get_children()
	for node in children:
		pos += node.position
	center = pos / children.size()
	camera.set_position(center)
	if Input.is_key_pressed(49):
		jitter = 15
		width = 10
	if Input.is_key_pressed(50):
		jitter = 20
		width = 100
	if Input.is_key_pressed(51):
		jitter = 30
		width = 300

func _physics_process(_delta):
	for node in get_children():
		if abs(center.x - node.position.x) > width:
			var offset = (center.x - node.position.x) / 15
			node.velocity.x += offset
		node.velocity += Vector2(rng.randf_range(-jitter, jitter), rng.randf_range(-jitter, jitter))
