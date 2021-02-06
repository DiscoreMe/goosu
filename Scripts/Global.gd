extends Node

export var debug_mode: bool = true
export var debug_circle_speed: float = 0.6 # 0.3 for release

export var score: int = 0
export var excellent: int = 0
export var ok: int = 0
export var bad: int = 0
export var misses: int = 0

export var font_string_debug: Font

func _ready():
	font_string_debug = load("res://Assets/Fonts/Roboto-Regular.tres") 
