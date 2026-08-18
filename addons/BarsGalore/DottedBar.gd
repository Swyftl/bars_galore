@tool
@icon("res://addons/BarsGalore/StaminaBar.svg")
## @experimental
## this node may break when changing the spacing
class_name DottedBar
extends Control

@export_category("Values")
@export var value : float = 100
@export var maxValue : float = 100

@export_category("Visual")
@export var antialiased : bool = true
@export var color : Color = Color.GREEN
@export var dot_radius : float = 5
@export var max_dots : int = 10
@export var dot_spacing : float = 5

func _process(_delta) -> void:
	queue_redraw()
	
func _draw():
	var bar_percentage: float = value/maxValue
	var shown_dots : int = bar_percentage * max_dots

	var spacing: float = (size.x / max_dots) + dot_spacing
	print(spacing)
	
	for dot_count in shown_dots:
		draw_circle(Vector2((spacing*dot_count), size.y/2), dot_radius, color, true, -1.0, antialiased)