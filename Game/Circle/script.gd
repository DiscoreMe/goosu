extends Node2D


export var start_position: Vector2 = Vector2(0, 0)

var time_start: int = 0
var time_end: int = 5

var rand_value: int = OS.get_ticks_msec()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var radius_start: float = 150.0
var radius_end: float = 50.0

var _radius: float = radius_start

func draw_circle_arc(center, radius, angle_from, angle_to, color):
	var nb_points = 64
	var points_arc = PoolVector2Array()

	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color, 5.0)

func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()
	points_arc.push_back(center)
	var colors = PoolColorArray([color])

	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc, colors)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	draw_circle_arc(start_position, _radius, 0, 360, Color.red)
	draw_circle_arc_poly(start_position, radius_end, 0, 360, Color.blue)
	
	if global.debug_mode:
		draw_string(global.font_string_debug, start_position, "Radius: %f" % [_radius])
		draw_string(global.font_string_debug, Vector2(start_position.x, start_position.y+20), "%ds" % [(time_end - OS.get_ticks_msec())/1000 + 1])
	
func _process(_delta):
	update()

func update_circle():
	if _radius <= radius_end:
		print("[circle] destroy")
		queue_free()

	var cur_time =  OS.get_ticks_msec() - time_start
	var dt = time_end - time_start
	var d_radius = radius_start - radius_end
	var k_speed = d_radius / dt 
	var t_radius = k_speed * cur_time # OS.get_ticks_msec()
	_radius = radius_start - t_radius
