class_name SavesData extends Resource

@export var saves : Array[WorldData]

func new_save() -> WorldData:
	var new_save_data = WorldData.new()
	saves.append(new_save_data)
	return new_save_data

func delete_save(index: int):
	saves.remove_at(index)
