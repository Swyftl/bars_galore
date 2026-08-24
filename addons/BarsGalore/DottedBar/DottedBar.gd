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
@export var dot_spacing : float = 5

func _process(_delta) -> void:
	queue_redraw()

func _draw():
	var size: Vector2 = get_size()

	var dot_diameter: float = dot_radius * 2
	var box_width: float = size.x

	var max_dots_no_spacing: int = floor(box_width / dot_diameter)
	
	var dot_amount: int = floor((box_width + dot_spacing) / (dot_diameter + dot_spacing))
	dot_amount = max(1, dot_amount)

	var actual_spacing: float = 0.0
	if dot_amount > 1:
		actual_spacing = (box_width - (dot_amount * dot_diameter)) / (dot_amount - 1)
	else:
		actual_spacing = 0.0

	if actual_spacing < dot_spacing:
		dot_amount = floor((box_width + dot_spacing) / (dot_diameter + dot_spacing))
		dot_amount = max(1, dot_amount)
		if dot_amount > 1:
			actual_spacing = (box_width - (dot_amount * dot_diameter)) / (dot_amount - 1)
		else:
			actual_spacing = 0.0

	var bar_percentage: float = value / maxValue
	var shown_dots: int = ceil(dot_amount * bar_percentage)

	for i in range(shown_dots):
		var x_pos: float = dot_radius + (i * (dot_diameter + actual_spacing))
		if x_pos + dot_radius > box_width:
			break

		draw_circle(Vector2(x_pos, size.y / 2), dot_radius, color, true, -1.0, antialiased)   