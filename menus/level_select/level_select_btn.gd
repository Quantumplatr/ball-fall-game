extends Button
class_name LevelSelectButton

signal on_level_select(lvl: LevelData)

@export var lvl_data : LevelData

func _on_pressed():
	on_level_select.emit(lvl_data)
