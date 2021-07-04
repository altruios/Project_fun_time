extends Node

var count = 0
var center = Vector2(0.0, 0.0)
var jitter = 25
var width = 100
var robot_count = 20
var jump_time = 50;
var jump_cool_down_timer=0

var spawn_functions = ["make_steve","make_bob","make_tim"]#more to add
onready var steve_tscn = load("res://steve_bot.tscn")
onready var bob_tscn = load("res://bob_bot.tscn")
onready var tim_tscn = load("res://tim_bot.tscn")
onready var rng = RandomNumberGenerator.new()
onready var camera = get_node("../camera")

func _ready():
	rng.randomize()
	for _i in range(robot_count):
		make_bob()
		make_steve()
		make_tim()

func set_random_bot_spawn_position(node):
	node.set_name("node")
	var offset = Vector2(rng.randf_range(-100, 100), rng.randf_range(-100, 100))
	node.set_position(center + offset) 

	add_child(node)
	
func make_bob():
	var node = bob_tscn.instance()
	set_random_bot_spawn_position(node)
func make_steve():
	var node = steve_tscn.instance()
	set_random_bot_spawn_position(node)
func make_tim():
	var node = tim_tscn.instance()
	set_random_bot_spawn_position(node)

	 
func make_random_robot():
	 #to implement actually
	 var random_index = rng.randi_range(0,len(spawn_functions)-1)#length of spawn functions 
	 var chosed_function = spawn_functions[random_index]

	 match chosed_function:
		  "make_steve":
			   make_steve()
		  "make_bob":
			   make_bob()
		  "make_tim":
			   make_tim();

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
func run_controls(node):
	node.velocity.y=node.velocity.y+node.gravity
	
	if (Input.is_action_pressed("left")):
		node.velocity.x-=node.speed
	if (Input.is_action_pressed("right")):
		node.velocity.x+=node.speed

	if(Input.is_action_just_pressed("jump") and jump_cool_down_timer < 1):
		node.velocity.y+=(node.jump_force*3)

	if (node.is_on_floor()):
		node.velocity.y=node.jump_force
		
	node.move_and_slide(node.velocity, Vector2.UP)
	node.velocity.x *= 0.95


func _physics_process(_delta):
	if(jump_cool_down_timer>0):
		jump_cool_down_timer=max(jump_cool_down_timer-1,0)
	for node in get_children():
		run_controls(node)
		if abs(center.x - node.position.x) > width:
			var offset = (center.x - node.position.x) / 15
			node.velocity.x += offset
		node.velocity += Vector2(rng.randf_range(-jitter, jitter), rng.randf_range(-jitter, jitter))
	if(Input.is_action_just_pressed("jump") and jump_cool_down_timer==0):
		jump_cool_down_timer=jump_time;
