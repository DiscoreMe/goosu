extends Node

export var debug_mode: bool = true
export var debug_circle_speed: int = 3

export var font_string_debug: Font

func _ready():
	font_string_debug = load("res://Assets/Fonts/Roboto-Regular.tres") 
