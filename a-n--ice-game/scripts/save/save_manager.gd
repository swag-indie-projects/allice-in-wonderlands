class_name SaveManager
extends Node

const SAVE_PATH = "user://savegame.tres" # text format for debugging

var current_save : SaveResource

var default_save_data : SaveResource

func _ready() ->void:
	default_save_data = SaveResource.new()
	default_save_data.set("coins", 0)
	default_save_data.set("spawn", Constant.Paths.PATH_TO_STARTING_WORLD)


func save_game() -> void:
	print("GAME IS SAVING..")
	if not current_save:
		printerr("no save data exusts")
		return
	var err = ResourceSaver.save(current_save, SAVE_PATH)
	if err != OK:
		printerr("failed to save: %s" % error_string(err))
	else:
		print("Game saved at: %s" % SAVE_PATH)

func load_game() -> bool:
	if not ResourceLoader.exists(SAVE_PATH):
		print("no save found, making enw save")
		current_save = default_save_data
		
		return false
	
	var loaded_resource = ResourceLoader.load(SAVE_PATH, "", ResourceLoader.CACHE_MODE_IGNORE)
	if (loaded_resource is SaveResource):
		current_save = loaded_resource
		print("game loaded successfully")
		return true
	else:
		print("failed to load save, making a new one")
		current_save = default_save_data
		return false

func get_save_data(key):
	return current_save.get(key)

func update_save_data(key, val) -> void:
	print("updated local save")
	current_save.set(key, val)
	print(key, " : ", get_save_data(key))
