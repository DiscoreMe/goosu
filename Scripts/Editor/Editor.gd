extends Node2D

var _game_time = 60

var _is_tiker_entered: bool = false
var _is_ticker_moving: bool = false

var _tiker: Node2D
var _media_player: Control

func _ready():
	$Panel/Node/LineEdit.text = str(_game_time)
	$Panel/MediaPlayer/Label2.text = str(_game_time)
	_tiker = get_node("Panel/MediaPlayer/Tiker")
	_media_player = get_node("Panel/MediaPlayer")

func _on_LineEdit_text_changed(new_text):
	_game_time = int(new_text)
	$Panel/MediaPlayer/Label2.text = str(_game_time)
	_tiker.set_value(_get_slice_time())

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 1:
			if _is_tiker_entered:
				_is_ticker_moving = true
		elif !event.pressed and event.button_index == 1:
			_is_ticker_moving = false
		
func _process(_delta):
	if _is_ticker_moving:
		var tiker_position = _tiker.position
		var mouse_position = get_global_mouse_position()
		var pos_x = mouse_position.x - _media_player.margin_left
		var end = $Panel/MediaPlayer.margin_right - $Panel/MediaPlayer.margin_left
		var val = _get_slice_time()
		if pos_x < 0.0:
			pos_x = 0.0
			_is_ticker_moving = false
		elif pos_x > end:
			pos_x = end-2
			_is_ticker_moving = false
		
		_tiker.position = Vector2(pos_x, tiker_position.y)		
		_tiker.set_value(val)
		
		#print("end=", end, " u=", u, " val=", val, " pos_x=", pos_x, " d(pos_x,end)=", end-pos_x)

func _get_slice_time() -> float:
	var tiker_position = _tiker.position
	var mouse_position = get_global_mouse_position()
	var pos_x = mouse_position.x - _media_player.margin_left
	var end = $Panel/MediaPlayer.margin_right - $Panel/MediaPlayer.margin_left
	return pos_x * _game_time / end

func _on_Tiker_mouse_entered():
	_is_tiker_entered = true

func _on_Tiker_mouse_exited():
	_is_tiker_entered = false
