@tool
@icon("res://addons/BarsGalore/StaminaBar.svg")

class_name TexturedDottedBar
extends Control


@export var value : float = 100
@export var maxValue : float = 100
@export var texture : Texture2D
@export var dot_radius : float = 5
@export var dot_spacing : float = 5

@export_category("Visual")
@export var color : Color = Color.GREEN
## Offsets the texture's size by the given amount. This is useful if your texture has a lot of blank space around it, meaning you can move the bounds in.
@export var texture_size_offset : Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
    queue_redraw()

func _draw():
    var size: Vector2 = get_size()

    if texture == null:
        return

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

    var texture_size: Vector2 = texture.get_size()
    var adjusted_texture_size: Vector2 = Vector2(
        max(1.0, texture_size.x - texture_size_offset.x),
        max(1.0, texture_size.y - texture_size_offset.y)
    )
    var render_diameter: float = min(dot_diameter, size.y)
    var texture_scale: float = min(
        render_diameter / adjusted_texture_size.x,
        render_diameter / adjusted_texture_size.y
    )
    var rendered_size: Vector2 = texture_size * texture_scale

    for i in range(shown_dots):
        var x_pos: float = dot_radius + (i * (dot_diameter + actual_spacing))
        if x_pos + dot_radius > box_width:
            break

        var texture_position: Vector2 = Vector2(x_pos, size.y / 2) - (rendered_size / 2)
        draw_texture_rect(texture, Rect2(texture_position, rendered_size), false, color)