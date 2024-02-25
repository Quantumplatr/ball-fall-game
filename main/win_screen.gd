extends CenterContainer
class_name WinScreen

func _ready():
	hide()
	
@onready var rankings = %Rankings
@onready var game_over_lbl = $Bg/Margins/VBox/GameOverLbl
@onready var play_again_btn = $Bg/Margins/VBox/Actions/PlayAgainBtn

func _on_results_on_game_over(results: Array[Ball]):
	# Clear rankings
	for child in rankings.get_children():
		child.queue_free()
	
	# Fill rankings
	for i in results.size():
		var ball := results[i]
		
		var name_lbl = Label.new()
		var wins_lbl = Label.new()
		
		name_lbl.text = "%s. %s" % [i+1, ball.ball_data.name]
		wins_lbl.text = str(ball.ball_data.wins)
		
		name_lbl.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		wins_lbl.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		
		rankings.add_child(name_lbl)
		rankings.add_child(wins_lbl)
	
	# Adjust game over text
	if results.size() > 0:
		game_over_lbl.text = "%s Won!" % [results[0].ball_data.name]
	
	show()
	play_again_btn.grab_focus()


func _on_play_again_btn_pressed():
	SceneManager.restart()


func _on_level_select_btn_pressed():
	SceneManager.go_to_scene("res://menus/level_select/level_select.tscn")
