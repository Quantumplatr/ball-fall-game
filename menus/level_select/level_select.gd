extends Control

@export var level_datas : Array[LevelData]

@onready var levels = %Levels
@onready var back_btn = $MarginContainer/VBoxContainer/Title/BackBtn

const LEVEL_SELECT_BTN = preload("res://menus/level_select/level_select_btn.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in levels.get_children():
		child.queue_free()
	
	for lvl in level_datas:
		var lvl_btn = LEVEL_SELECT_BTN.instantiate()
		lvl_btn.icon = lvl.icon
		lvl_btn.text = "%s\nBy %s" % [lvl.title, lvl.author]
		lvl_btn.lvl_data = lvl
		lvl_btn.on_level_select.connect(_on_level_select)
		levels.add_child(lvl_btn)
	
	back_btn.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_btn_pressed():
	SceneManager.go_to_scene("res://menus/save_edit/save_edit.tscn")

func _on_level_select(lvl: LevelData):
	SceneManager.go_to_level(lvl)
