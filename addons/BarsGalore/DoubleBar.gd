@tool
@icon("res://addons/BarsGalore/StaminaBar.svg")

class_name DoubleBar
extends Control

@export_category("Values")
@export var value_one : float = 100
@export var value_two : float = 100
@export var value_one_max : float = 100
@export var value_two_max : float = 100

@export_category("Visual")
@export var antialiased : bool = true

@export_group("Bar One")
@export var bar_one_color : Color = Color.GREEN
@export var bar_one_width : float = 10.0
@export var bar_one_size_offset : float = 0.0

@export_group("Bar Two")
@export var bar_two_color : Color = Color.BLUE
@export var bar_two_width : float = 5.0
@export var bar_two_size_offset : float = 0.0

func _process(_delta):
	queue_redraw()

func _draw():
	# Changes the height to be the true center
	var rect_height: float = size.y / 2
	
	# Gets the percentage of the two values
	var rect_one_percentage: float = value_one/value_one_max
	var rect_two_percentage: float = value_two/value_two_max
	
	var rect_one: Rect2i = Rect2i(bar_one_size_offset/2, rect_height-(bar_one_width/2), (rect_one_percentage)*(size.x - bar_one_size_offset), bar_one_width)
	var rect_two: Rect2i = Rect2i(bar_two_size_offset/2, rect_height-(bar_two_width/2), (rect_two_percentage)*(size.x - bar_two_size_offset), bar_two_width)
	draw_rect(rect_one, bar_one_color, true, -1.0, antialiased)
	draw_rect(rect_two, bar_two_color, true, -1.0, antialiased)