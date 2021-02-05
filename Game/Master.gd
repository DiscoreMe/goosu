extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var circle_instance = load("res://Game/Circle/Circle.tscn")
onready var circle_node: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	circle_node = get_node("Circles")

var count = 0

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var circle = circle_instance.instance()
			circle.start_position = event.position
			count += 1
			
			var start_time = OS.get_ticks_msec()
			var end_time = start_time + global.debug_circle_speed * 1000
			circle.time_start = start_time
			circle.time_end = end_time
			
			
			
			circle_node.add_child(circle)
	elif event is InputEventKey:
		if event.is_action_pressed("ui_tilde"):
			pass
		
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()

func _draw():
	if global.debug_mode:
		draw_string(global.font_string_debug, Vector2(5, 15), "Circles running: %d" % [circle_node.get_child_count()])	
		draw_string(global.font_string_debug, Vector2(5, 30), "get tick ms: %d" %  OS.get_ticks_msec())


func _on_GameTimer_timeout():
	for circle in circle_node.get_children():
		circle.update_circle()
