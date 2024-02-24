extends Node2D
class_name Main


@export_group("Data")
@export var world_data: WorldData
@export var level_data: LevelData
@export_group("Components")
@export var results: ResultsComponent
@export var balls_container: BallsContainer
@export var placements : PlacementsComponent

@onready var level_container = $LevelContainer

var balls : Array[Ball]


func _ready():
	
	# Update world and level
	level_data = SceneManager.current_level
	world_data = SaveManager.get_current_save()
	
	# Load level
	var lvl : LevelData = SceneManager.current_level
	if lvl:
		for child in level_container.get_children():
			child.queue_free()
		
		var lvl_inst = lvl.scene.instantiate()
		balls_container.level = lvl_inst
		level_container.add_child(lvl_inst)
	
	
	# Generate Balls
	balls_container.set_balls(world_data.balls)
	

func _unhandled_input(event):
	if event.is_action("restart") and event.is_pressed():
		SceneManager.restart()


func _on_pause_menu_on_play():
	get_tree().paused = false


func _on_pause_menu_on_pause():
	get_tree().paused = true
