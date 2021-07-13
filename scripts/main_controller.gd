extends Node

var count = 0
var center_of_view = Vector2(0.0, 0.0)

const selected_robot = ["all","bob","tim","steve"];
var selected_robot_index = 0;


var jitter = 25
var width = 100
var robot_count = 100
var jump_time = 50;
var jump_cool_down_timer=0
var health=0;
var spawn_functions = ["make_steve","make_bob","make_tim"]#more to add 
onready var steve_tscn = load("res://robots/Steve_bot.tscn")
onready var bob_tscn = load("res://robots/Bob_bot.tscn")
onready var tim_tscn = load("res://robots/Tim_bot.tscn")
onready var rng = RandomNumberGenerator.new()
onready var camera = get_node("../camera")

#for debugging and display stuff

signal make_robot(name)
signal change_health(health)
signal select_robot(name)
func get_robot():
	return selected_robot[selected_robot_index];

func _ready():
	rng.randomize()
	for _i in range(robot_count):
		_i=_i+make_random_robot()
		
func set_random_bot_spawn_position(node):
	node.set_name("node")
	var offset = Vector2(
		rng.randf_range(-100, 100), 
		rng.randf_range(-100, 100)
	)
	node.set_position(center_of_view + offset) 	
func make_bob():
	var node = bob_tscn.instance()
	health=health+1;
	set_random_bot_spawn_position(node)
	signal_add_robot("Bob")
	add_child(node)	 


func make_steve():
	health=health+2;
	var node = steve_tscn.instance()
	set_random_bot_spawn_position(node)
	signal_add_robot("Steve")
	add_child(node)	 
	

func make_tim():
	health=health+3;
	var node = tim_tscn.instance()
	set_random_bot_spawn_position(node)
	signal_add_robot("Tim")
	add_child(node)	 

func make_random_robot():
	#to implement actually
	var random_index = rng.randi_range(0,len(spawn_functions)-1)#length of spawn functions 
	var chosen_function = spawn_functions[random_index]

	match chosen_function:
		"make_steve":
			make_steve()
			return 1
		"make_bob":
			make_bob()
			return 2
		"make_tim":
			make_tim();
			return 3	
		
func _process(_delta):


	
	if Input.is_action_pressed("center_bob"):	
		selected_robot_index=1
		emit_signal("select_robot",get_robot())
		
	if Input.is_action_pressed("center_tim"):
		selected_robot_index=2
		emit_signal("select_robot",get_robot())
		
	if Input.is_action_pressed("center_steve"):
		selected_robot_index=3
		emit_signal("select_robot",get_robot())
		
	if Input.is_action_pressed("center_all"):
		selected_robot_index=0
		emit_signal("select_robot",get_robot())	
	set_camera_view()


func run_controls(node, type):
	node.move_and_slide(node.velocity, Vector2.UP)
	node.velocity.x *= 0.95
	if(node.type!=type and type !="all"):
		return; #



	if (Input.is_action_pressed("left")):
		node.velocity.x-=node.speed
	if (Input.is_action_pressed("right")):
		node.velocity.x+=node.speed

	if(Input.is_action_just_pressed("jump") and jump_cool_down_timer < 1):
		node.velocity.y+=(node.jump_force*3)
#	node.move_and_slide(node.velocity, Vector2.UP)

func _physics_process(_delta):
	if(jump_cool_down_timer>0):
		jump_cool_down_timer=max(jump_cool_down_timer-1,0)
	for node in get_children():
		run_controls(node,get_robot())
		node.velocity.y=node.velocity.y+node.gravity
		if (node.is_on_floor()):
			node.velocity.y=node.jump_force

		node.velocity += Vector2(
			rng.randf_range(-jitter, jitter), 
			rng.randf_range(-jitter, jitter)
		)
	if(Input.is_action_just_pressed("jump") and jump_cool_down_timer==0):
		jump_cool_down_timer=jump_time;

func spread_out():
	jitter = 30
	width = 300 ;
func tighten_in():
	jitter = 15
	width = 10
func set_camera_view():
	var pos_chosen_view = Vector2(0,0)
	var children = get_children()
	var size =0;
	for node in children:
		var r = get_robot()
		if(r=="all" or r==node.type):
			pos_chosen_view.x+=node.position.x
			pos_chosen_view.y+=node.position.y
			size=size+1
			if abs(center_of_view.x - node.position.x) > width:
				var offset = (center_of_view.x - node.position.x) / 15
				node.velocity.x += offset
	center_of_view = pos_chosen_view / size
	camera.set_position(center_of_view)

	
	
func signal_add_robot(robot):
	emit_signal("make_robot", robot)
	emit_signal("change_health",health)
