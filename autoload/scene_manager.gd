extends Node

# HELP FROM: https://docs.godotengine.org/en/4.2/tutorials/scripting/singletons_autoload.html#custom-scene-switcher

var current_scene : Node = null

var current_level : LevelData = null

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	
func _deferred_goto_scene(path, callback: Callable):
	# It is now safe to remove the current scene.
	if is_instance_valid(current_scene):
		current_scene.free()
	else:
		get_tree().unload_current_scene()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instantiate()

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
	
	callback.call()
	
func go_to_scene(path, callback: Callable = func(): pass):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	call_deferred("_deferred_goto_scene", path, callback)
	
func go_to_save_edit(save: WorldData) -> void:
	
	SaveManager.set_current_save(save)
	
	go_to_scene("res://menus/save_edit/save_edit.tscn")

func go_to_level(lvl: LevelData) -> void:
	
	current_level = lvl
	
	go_to_scene("res://main/main.tscn")

func restart() -> void:
	go_to_level(current_level)
