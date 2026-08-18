@tool
@icon("res://addons/BarsGalore/StaminaBar.svg")

class_name ParellelBar
extends Control

@export var valueOne : float = 100
@export var valueTwo : float = 100
@export var valueOneMax : float = 100
@export var valueTwoMax : float = 100
@export var barHeight : float = 10
@export var antialiased : bool = true

func _process(delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	print(valueOne/valueOneMax)
	print(valueTwo/valueTwoMax)
	
	var center_x : float =  size.x * 0.5
	var center_y : float = size.y * 0.5 - barHeight * 0.5
	
	var one_percent : float = (valueOne/valueOneMax) if valueOneMax > 0.0 else 0.0
	var two_percent : float = (valueTwo/valueTwoMax) if valueTwoMax > 0.0 else 0.0
	
	one_percent = clampf(one_percent, 0.0, 1.0)
	two_percent = clampf(two_percent, 0.0, 1.0)
	
	var one_width : float = center_x * one_percent
	var two_width : float = center_x * two_percent
	
	var barOneRect : Rect2 = Rect2(center_x - one_width, center_y, one_width, barHeight)
	var barTwoRect : Rect2 = Rect2(center_x, center_y, two_width, barHeight)
	
	draw_rect(barOneRect, Color.BLUE, true, -1.0, antialiased)
	draw_rect(barTwoRect, Color.RED, true, -1.0, antialiased)
