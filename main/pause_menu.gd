extends CenterContainer

signal on_pause()
signal on_play()

func _ready():
	hide()

func _input(event):
	if event.is_action("pause_menu") and event.is_pressed():
		if visible:
			hide()
			on_play.emit()
		else:
			show()
			on_pause.emit()

func _on_restart_btn_pressed():
	on_play.emit()
	SceneManager.restart()


func _on_lvl_select_btn_pressed():
	on_play.emit()
	SceneManager.go_to_scene("res://menus/level_select/level_select.tscn")


func _on_quit_btn_pressed():
	get_tree().quit()
