@tool
extends Wall

@onready var follower = $".."
@onready var moving_wall = $"../.."

@export var speed : float = 100

var reverse := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	follower.progress += speed * delta * (-1 if reverse else 1)
	
	if not follower.loop:
		if follower.progress_ratio == 1:
			reverse = true
		elif follower.progress_ratio == 0:
			reverse = false
