class_name Ball extends RigidBody2D

signal on_reached_end(ball: Ball)
signal on_reached_loss(ball: Ball)

@export var ball_data: BallData


@onready var label = %Label
@onready var sprite = %Sprite
@onready var label_container = $LabelContainer
@onready var trail = %Trail


# Called when the node enters the scene tree for the first time.
func _ready():
	update()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label_container.global_rotation = 0 # Don't rotate label

func at_end():
	on_reached_end.emit(self)

func set_data(_ball_data: BallData):
	ball_data = _ball_data
	update()

func update():
	if !ball_data or not is_node_ready():
		return
	
	label.text = ball_data.name
	sprite.self_modulate = ball_data.main_color
	
	trail.gradient = Gradient.new()
	trail.gradient.offsets = [1,0]
	trail.gradient.colors = [ball_data.trail_start_color, ball_data.trail_end_color]
