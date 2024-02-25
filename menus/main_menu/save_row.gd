class_name SaveRow extends HBoxContainer

signal on_name_pressed(save: WorldData)
signal on_delete_pressed(index: int)

@onready var name_btn = $Name

@export var save_data: WorldData

func _ready():
	if save_data:
		name_btn.text = save_data.name

func _on_name_pressed():
	on_name_pressed.emit(save_data)


func _on_delete_pressed():
	on_delete_pressed.emit(get_index())

func focus():
	name_btn.grab_focus()
