extends Camera2D

enum CAMERA_MODES { LOWEST, HIGHEST, AVERAGE }

const CAMERA_MODE_NAMES = {
	CAMERA_MODES.LOWEST: "Lowest Ball",
	CAMERA_MODES.HIGHEST: "Highest Ball",
	CAMERA_MODES.AVERAGE: "Average Position",
}

@export var cam_mode_lbl : Label
@export_range(0,1) var cam_speed := 0.1
@export var balls_container : BallsContainer

var cam_pos : Vector2 = Vector2.ZERO

var cam_mode : CAMERA_MODES = CAMERA_MODES.LOWEST : 
	set(value):
		cam_mode = value
		if cam_mode_lbl:
			cam_mode_lbl.text = "Camera Mode: %s" % [CAMERA_MODE_NAMES[cam_mode]]

func _ready():
	if cam_mode_lbl:
		cam_mode_lbl.text = "Camera Mode: %s" % [CAMERA_MODE_NAMES[cam_mode]]
	
	update_position(true)

func _physics_process(delta):
	update_position()

func _unhandled_input(event):
	if event.is_action("cam_mode_1"):
		cam_mode = CAMERA_MODES.LOWEST
	elif event.is_action("cam_mode_2"):
		cam_mode = CAMERA_MODES.HIGHEST
	elif event.is_action("cam_mode_3"):
		cam_mode = CAMERA_MODES.AVERAGE
	elif event.is_action("cam_mode_cycle"):
		cam_mode = (cam_mode + 1) % CAMERA_MODES.size()


func update_position(snap := false):
	# Set camera to 
	match cam_mode:
		CAMERA_MODES.LOWEST:
			var lowest_ball := balls_container.get_lowest_ball()
			if lowest_ball:
				cam_pos = lowest_ball.position
		CAMERA_MODES.HIGHEST:
			var highest_ball := balls_container.get_highest_ball()
			if highest_ball:
				cam_pos = highest_ball.position
		CAMERA_MODES.AVERAGE:
			var avg_pos := balls_container.get_average_ball_pos()
			if avg_pos:
				cam_pos = avg_pos
	
	if not snap:
		position = lerp(position, cam_pos, cam_speed)
	else:
		position = cam_pos

