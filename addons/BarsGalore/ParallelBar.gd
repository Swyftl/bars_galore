@tool
@icon("res://addons/BarsGalore/StaminaBar.svg")

class_name ParellelBar
extends Control

@export var valueOne : float = 100
@export var valueTwo : float = 100
@export var valueOneMax : float = 100
@export var valueTwoMax : float = 100
@export_category("Style")
@export var barHeight : float = 10
@export var antialiased : bool = true
@export var roundCorners : bool = true
@export_category("Colours")
@export var barOneColor : Color = Color.BLUE
@export var barTwoColor : Color = Color.RED

func _process(delta: float) -> void:
	queue_redraw()

func _draw() -> void:	
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
	
	draw_rect(barOneRect, barOneColor, true, -1.0, antialiased)
	draw_rect(barTwoRect, barTwoColor, true, -1.0, antialiased)
	if roundCorners:
		draw_circle(Vector2(center_x - one_width, center_y+(barHeight/2)), barHeight/2, barOneColor, true, -1.0, antialiased)
		draw_circle(Vector2(center_x+two_width, center_y+(barHeight/2)), barHeight/2, barTwoColor, true, -1.0, antialiased)
