@tool
extends Wall

@export var speed := 1.0
@export var pause := false
@export var randomize_speed := false
@export var randomize_range := 10.0
@export var starting_angle := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if randomize_speed:
		speed *= randf() * randomize_range + 1
		speed *= [-1,1].pick_random()
	pause = false
	rotation = deg_to_rad(starting_angle)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not pause:
		rotate(delta * speed)
	else:
		rotation = deg_to_rad(starting_angle)
