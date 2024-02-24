extends Control

@onready var saves_list = $Center/VBox/ScrollContainer/Saves

var SaveRowScene = preload("res://menus/main_menu/save_row.tscn")

var to_delete = -1 # Index of save to delete

@onready var confirm_delete = $ConfirmDelete

# Called when the node enters the scene tree for the first time.
func _ready():
	update_saves_list()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_new_save_pressed():
	SaveManager.new_save()
	update_saves_list()

func _on_delete_pressed(index):
	confirm_delete.show()
	to_delete = index

func _on_confirm_delete():
	SaveManager.delete_save(to_delete)
	update_saves_list()

func _on_save_pressed(save: WorldData):
	SceneManager.go_to_save_edit(save)
	

func update_saves_list():
	
	for child in saves_list.get_children():
		child.queue_free()
	
	for save in SaveManager.get_saves():
		var save_row = SaveRowScene.instantiate() as SaveRow
		save_row.save_data = save
		save_row.on_delete_pressed.connect(_on_delete_pressed)
		save_row.on_name_pressed.connect(_on_save_pressed)
		saves_list.add_child(save_row)


func _on_quit_pressed():
	get_tree().quit()
