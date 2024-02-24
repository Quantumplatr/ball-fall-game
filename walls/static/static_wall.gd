@tool
class_name StaticWall
extends Wall

@export_range(-180,180,5) var angle := 0.0:
	set(v):
		angle = v
		rotation = deg_to_rad(angle)
