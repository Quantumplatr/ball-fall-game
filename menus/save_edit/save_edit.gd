extends Control

@onready var back_btn = %BackBtn
@onready var save_name = %SaveName
@onready var play_btn = %PlayBtn

@onready var balls_container = %BallsContainer

@onready var confirm_delete = $ConfirmDelete

@export var save_data : WorldData :
	set(value):
		save_data = value
		update_visuals()

var BallEditScene = preload("res://menus/save_edit/ball_edit.tscn")

var to_delete = -1 # Index of ball to delete

func _ready():
	save_data = SaveManager.get_current_save()
	update_visuals()
	
	play_btn.grab_focus()

# TODO: rename as it's now on change
func _on_save_name_text_submitted(new_text):
	save_data.name = new_text
	SaveManager.save()


func _on_back_btn_pressed():
	SceneManager.go_to_scene("res://menus/main_menu/main_menu.tscn")


func _on_play_btn_pressed():
	SceneManager.go_to_scene("res://menus/level_select/level_select.tscn")


func _on_sort_by_name_pressed():
	pass # Replace with function body.


func _on_sort_by_wins_pressed():
	pass # Replace with function body.

func _on_create_ball_btn_pressed():
	save_data.add_ball()
	update_visuals()
	SaveManager.save()

func _on_ball_delete(index: int):
	confirm_delete.show()
	to_delete = index

func _on_confirm_delete():
	save_data.delete_ball(to_delete)
	SaveManager.save()
	update_visuals()

func update_visuals():
	
	save_name.text = save_data.name
	
	for child in balls_container.get_children():
		child.queue_free()
	
	for ball in save_data.balls:
		var ball_edit = BallEditScene.instantiate() as BallEdit
		ball_edit.ball_data = ball
		ball_edit.on_delete.connect(_on_ball_delete)
		balls_container.add_child(ball_edit)
