@tool
@icon("res://addons/BarsGalore/StaminaBar.svg")

class_name StaminaBar
extends Control

@export var value : float = 100
@export var max_value : float = 100
@export_group("Visual")
@export var point_count : int = 20
@export var color : Color = Color.ALICE_BLUE
@export var antialiased : bool = true
@export var width : float = 2.0
@export var rounded_edges : bool = true

func _enter_tree():
	pass

func _process(delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	var radius : float = min(size.x - (width), size.y - (width)) / 2.0
	var center := size / 2.0

	# Prevent division by zero and keep the value in a valid range.
	var ratio := 0.0
	if max_value > 0.0:
		ratio = clamp(value / max_value, 0.0, 1.0)

	# draw_arc uses radians, so TAU is one complete circle.
	var start_angle := -PI / 2.0
	var end_angle := start_angle + ratio * TAU

	draw_arc(
		center,
		radius,
		start_angle,
		end_angle,
		point_count,
		color,
		width,
		antialiased
	)
	if rounded_edges:
		draw_circle(Vector2(center.x, center.y - radius), width/2, color, true, -1.0, antialiased)
		var end_position := center + Vector2(cos(end_angle), sin(end_angle)) * radius
		draw_circle(end_position, width/2, color, true, -1.0, antialiased)
