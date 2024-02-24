extends Node

var _saves_data : SavesData
var _current_save : WorldData

func _ready():
	_saves_data = ResourceLoader.load("res://saves.tres")

func save():
	ResourceSaver.save(_saves_data)

func new_save():
	_saves_data.new_save()
	save()

func delete_save(index: int):
	_saves_data.delete_save(index)
	save()

func get_saves() -> Array[WorldData]:
	return _saves_data.saves

func set_current_save(save: WorldData):
	_current_save = save

func get_current_save() -> WorldData:
	return _current_save
