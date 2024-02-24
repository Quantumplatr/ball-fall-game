class_name Trail extends Line2D


@export var trail_length := 50

const MAX_POINTS := 100

@onready var curve := Curve2D.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	curve.add_point(get_parent().position)
	
	if curve.get_baked_length() > trail_length:
		curve.remove_point(0)
	
	if curve.point_count > MAX_POINTS:
		curve.remove_point(0)
	
	points = curve.get_baked_points()
	
