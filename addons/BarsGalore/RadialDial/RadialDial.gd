@tool
@icon("res://addons/BarsGalore/StaminaBar.svg")

class_name RadialDial
extends Control

@export var value : float = 50
@export var maxValue : float = 100
## The amount of detail in the dial, more steps = more detail, but more expensive to render.
@export var stepCount : float = 10
## The angle that the pin will be at when the value is set to 0
@export var pinStartAngle : float = 90.0
## The angle that the pin will be at when the value is set to maxValue.
@export var pinEndAngle : float = 270.0

@export_category("Visual")
## The length of the pin as a percentage of the radius of the circle, 0-1
@export_range(0, 1) var pin_percentage : float = 0.8
@export var circleColor : Color = Color.GREEN
@export var pinColor : Color = Color.GREEN
## The width of the line that makes up the circle and the pin, in pixels.
@export var width : float = 10.0
@export var antialiased : bool = true
## Whether or not to show the start and end markers for the pin. Which are drawn at the start and end angles of the pin.
@export var show_start_end_markers : bool = true

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

	if show_start_end_markers:
		var start_angle_rad: float = deg_to_rad(pinStartAngle+90)
		var start_end: Vector2 = center + Vector2(cos(start_angle_rad), sin(start_angle_rad)) * pin_length
		draw_circle(start_end, width/2, pinColor, true, -1.0, antialiased)

		var end_angle_rad: float = deg_to_rad(pinEndAngle+90)
		var end_end: Vector2 = center + Vector2(cos(end_angle_rad), sin(end_angle_rad)) * pin_length
		draw_circle(end_end, width/2, pinColor, true, -1.0, antialiased)

	draw_line(center, pin_end, pinColor, width, antialiased)