extends Node2D

var _label: Label

func _ready():
	_label = get_node("Label")

func set_value(l: float):
	_label.text = "%0.02f" % l
