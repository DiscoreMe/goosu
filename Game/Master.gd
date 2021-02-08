extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var screen_size: Vector2 = OS.window_size

onready var excellent_score: int = 300
onready var ok_score: int = 100
onready var bad_score: int = 50

var excellent_count: int
var ok_count: int
var bad_count: int
var miss_count: int
var score: int

var circle_instance = load("res://Game/Circle/Circle.tscn")
onready var circle_node: Node

var rng = RandomNumberGenerator.new()
onready var circles_at_all: int = rng.randi_range(0, 100)

# Called when the node enters the scene tree for the first time.
func _ready():
	circle_node = get_node("Circles")
	

var count = 0

func consider_hit(type: String):
	match type:
		"excellent":
			excellent_count += 1
			score += excellent_score
		"ok":
			ok_count += 1
			score += ok_score
		"bad":
			bad_count +=1
			score += bad_score
		"miss":
			miss_count += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()
	
	

func _draw():
	if global.debug_mode:
		draw_string(global.font_string_debug, Vector2(5, 15), "get tick ms: %d" %  OS.get_ticks_msec())
		draw_string(global.font_string_debug, Vector2(5, 30), "FPS: %d" % Performance.get_monitor(Performance.TIME_FPS))
		
		draw_string(global.font_string_debug, Vector2(5, 50), "Misses: %d" % miss_count)
		draw_string(global.font_string_debug, Vector2(5, 70), "300: %d" % excellent_count)
		draw_string(global.font_string_debug, Vector2(5, 100), "100: %d" % ok_count)
		draw_string(global.font_string_debug, Vector2(5, 130), "50: %d" % bad_count)
		draw_string(global.font_string_debug, Vector2(5, 160), "Score: %d" % score)

func _on_SpawnerTimer_timeout():
	var circle = circle_instance.instance()
	var x: int = rng.randi_range(100, screen_size.x-100)
	var y: int = rng.randi_range(100, screen_size.y-100)
	circle.start_position = Vector2(x,y)
	count += 1
	var start_time = OS.get_ticks_msec()
	var end_time = start_time + global.debug_circle_speed * 1000
	circle.time_start = start_time
	circle.time_end = end_time
	circle_node.add_child(circle)
	

func _on_GameTimer_timeout():
	for circle in circle_node.get_children():
		circle.update_circle()
