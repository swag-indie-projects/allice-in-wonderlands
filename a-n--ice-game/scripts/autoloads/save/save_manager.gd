extends Node

const SAVE_PATH = "user://savegame.tres" # text format for debugging

var current_save : SaveResource

var default_save_data : SaveResource

func _ready() ->void:
	default_save_data = SaveResource.new()
	default_save_data.set("coins", Constant.PLAYER_STARTING_COINS)
	default_save_data.set("spawn", Constant.Paths.PATH_TO_STARTING_WORLD)
	default_save_data.bosses_killed = {
		Constant.Boss_Enum.Snowball: false,
		Constant.Boss_Enum.Witch: false
	}
	default_save_data.coins_collected_map = {}
	default_save_data.HP = Constant.PLAYER_STARTING_HP
	default_save_data.MAX_HP = Constant.PLAYER_STARTING_HP
	default_save_data.sword_scale = Constant.PLAYER_STARTING_SWORD_SCALE
	default_save_data.abilities_collected = {
		Constant.Abilities.Dash: false,
		Constant.Abilities.Freeze: false,
	}
	self.load_game()

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

func load_game() -> void:
	if not ResourceLoader.exists(SAVE_PATH):
		print("no save found, making meow moew moew moew save")
		current_save = default_save_data
		print(current_save)
	else:
		var loaded_resource = ResourceLoader.load(SAVE_PATH, "", ResourceLoader.CACHE_MODE_IGNORE)
		if (loaded_resource is SaveResource):
			current_save = loaded_resource
			print("game loaded successfully")
			print(current_save)
		else:
			print("failed to load save, making a new one")
			current_save = default_save_data
		
func load_game_stats() -> void:
	# setup all the proper UI, etc, etc
	Globals.game.player.HP = self.current_save.HP
	Globals.game.player.MAX_HP = self.current_save.MAX_HP
	Globals.game.player_ui.update_healthbar.emit(self.current_save.HP, self.current_save.MAX_HP)
	Globals.game.player_ui.update_coin.emit(self.current_save.coins)
	Globals.game.player.sword_swipe.scale.y = self.current_save.sword_scale

	
	
func get_save_data(key):
	return current_save.get(key)

func update_save_data(key, val) -> void:
	print("updated local save")
	current_save.set(key, val)
	print(key, " : ", get_save_data(key))

func update_coin(uuid : String) -> void:
	self.current_save.coins_collected_map.set(uuid, true)
