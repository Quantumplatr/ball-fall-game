extends Control
class_name BallEdit

signal on_delete(index: int)

@export var ball_data : BallData :
	set(val):
		ball_data = val
		update_visuals()
		
@onready var name_edit = %NameEdit
@onready var color_btn = %ColorBtn
@onready var start_btn = %StartBtn
@onready var end_btn = %EndBtn
@onready var active_btn = %ActiveBtn

@onready var trail = %Trail
@onready var ball = %Ball

@onready var wins_lbl = $Display/WinsLbl

# Called when the node enters the scene tree for the first time.
func _ready():
	update_visuals()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_visuals():
	if not ball_data or not is_node_ready():
		return
	
	name_edit.text = ball_data.name
	color_btn.color = ball_data.main_color
	start_btn.color = ball_data.trail_start_color
	end_btn.color = ball_data.trail_end_color
	
	active_btn.button_pressed = not ball_data.inactive
	
	ball.self_modulate = ball_data.main_color
	var gradient = Gradient.new()
	gradient.offsets = [0,1]
	gradient.colors = [ball_data.trail_start_color, ball_data.trail_end_color]
	var grad_tex = GradientTexture1D.new()
	grad_tex.gradient = gradient
	trail.material = ShaderMaterial.new()
	trail.material.shader = load("res://menus/save_edit/ball_edit.gdshader")
	trail.material.set_shader_parameter("gradient_texture", grad_tex)
	
	wins_lbl.text = "Wins: %s" % [ball_data.wins]


func _on_name_edit_text_changed(new_text):
	ball_data.name = new_text
	SaveManager.save()


func _on_color_btn_color_changed(color):
	ball_data.main_color = color
	SaveManager.save()
	update_visuals()


func _on_start_btn_color_changed(color):
	ball_data.trail_start_color = color
	SaveManager.save()
	update_visuals()


func _on_end_btn_color_changed(color):
	ball_data.trail_end_color = color
	SaveManager.save()
	update_visuals()


func _on_delete_btn_pressed():
	on_delete.emit(get_index())


func _on_active_btn_toggled(toggled_on):
	ball_data.inactive = not toggled_on
	SaveManager.save()
