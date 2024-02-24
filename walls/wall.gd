@tool
extends PhysicsBody2D
class_name Wall

@export var size := Vector2(1,1):
	set(v):
		size = v
		scale = size
