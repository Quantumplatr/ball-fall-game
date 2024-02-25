@tool
extends Path2D

@onready var body = $Follower/Body
@onready var follower = $Follower

@export var speed := 100:
	set(v):
		speed = v
		if body:
			body.speed = speed
			
@export var size := Vector2(1,1):
	set(v):
		size = v
		if body:
			body.size = size
@export var loop := true:
	set(v):
		loop = v
		if follower:
			follower.loop = loop
			
@export_range(-180,180,5) var angle := 0.0:
	set(v):
		angle = v
		if body:
			body.rotation = deg_to_rad(angle)

# Called when the node enters the scene tree for the first time.
func _ready():
	body.speed = speed
	body.size = size
	body.rotation = deg_to_rad(angle)
	follower.loop = loop


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
