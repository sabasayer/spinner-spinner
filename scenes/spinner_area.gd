@tool
class_name SpinnerArea extends Node2D

enum AreaType { EMPTY, EARN_FIXED, LOSE_FIXED }

@export var radius: float = 80.0:
	set(value):
		radius = value
		queue_redraw()

@export var color: Color = Color.GREEN:
	set(value):
		color = value
		queue_redraw()

# More points = smoother edge
@export_range(3, 128, 1) var detail: int = 32:
	set(value):
		detail = value
		queue_redraw()
		

@export var type: AreaType:
	set(value):
		type = value
		queue_redraw()

@export_range(-360.0, 360.0) var start_angle: float:
	set(value):
		start_angle = value
		queue_redraw()
		
@export_range(-360.0, 360.0) var end_angle: float:
	set(value):
		end_angle = value
		queue_redraw()
		
@export var amount: int = 1:
	set(value):
		amount = value
		queue_redraw()

func apply() -> int:
	match type:
		AreaType.EARN_FIXED:
			return amount
		AreaType.LOSE_FIXED:
			return  -amount
		AreaType.EMPTY:
			return 0
		_:
			return 0

		
func _ready() -> void:
	queue_redraw()

func _draw() -> void:
	# Center of the circle in local space
	var center := Vector2.ZERO

	# Build the points of a triangle fan:
	# first the center, then points along the arc.
	var points: Array = []
	points.append(center)

	# We’ll draw from -angle/2 to +angle/2 so it’s centered “upwards”.
	var start_angle_rad := deg_to_rad(start_angle)
	var end_angle_rad := deg_to_rad(end_angle)

	for i in range(detail + 1):
		var t := float(i) / float(detail)   # 0..1
		var a :float = lerp(start_angle_rad, end_angle_rad, t)
		var x := center.x + radius * cos(a)
		var y := center.y + radius * sin(a)
		points.append(Vector2(x, y))

	# Fill the fan as a polygon
	var packed_points := PackedVector2Array(points)
	draw_colored_polygon(packed_points, color)
	draw_effect(points)
	
func draw_effect(points:Array):
	if type == AreaType.EMPTY:
		return
		
	var text = ""
	match type:
		AreaType.EARN_FIXED:
			text = "+%s" % amount
		AreaType.LOSE_FIXED:
			text = "-%s" % amount
		
	var middlePoint = points[detail / 2]
	draw_string(ThemeDB.fallback_font,middlePoint / 2, text,HORIZONTAL_ALIGNMENT_CENTER, -1, 12)

func animate():
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(self,"scale",Vector2(1.2,1.2),0.5)
	tween.tween_property(self,"scale",Vector2.ONE, 0.3)
	return tween.finished
