@tool
@icon("res://addons/BarsGalore/StaminaBar.svg")

class_name RadialDial
extends Control

@export var value : float = 50
@export var maxValue : float = 100
@export var stepCount : float = 10
@export var pinStartAngle : float = 90.0
@export var pinEndAngle : float = 270.0

@export_category("Visual")
@export_range(0, 1) var pin_percentage : float = 0.8
@export var circleColor : Color = Color.GREEN
@export var pinColor : Color = Color.GREEN
@export var width : float = 10.0
@export var antialiased : bool = true

func _process(delta: float) -> void:
	queue_redraw()
	
func _draw() -> void:
	## Draw the main circle to house the dial
	var radius : float = min(size.x - (width), size.y - (width)) / 2.0
	var center := size / 2.0
	
	draw_circle(Vector2(center), radius, circleColor, false, width, antialiased)
	
	## Render the pin, getting the angle in the circle from 0-1
	var pinPercentage: float = value/maxValue
	var pinAngle: float = pinStartAngle + (pinEndAngle - pinStartAngle) * pinPercentage

	var angle_rad: float = deg_to_rad(pinAngle+90)
	var pin_length: float = radius * pin_percentage
	var pin_end: Vector2 = center + Vector2(cos(angle_rad), sin(angle_rad)) * pin_length

	draw_line(center, pin_end, pinColor, width, antialiased)