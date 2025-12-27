class_name GameState extends Node

static var coins = 0

var config = ConfigFile.new()

func _ready():
	$"..".coin_change.connect(_on_coin_change)

func load_config() -> void:
	var err = config.load("user://save.cfg")
	if err != OK:
		print("failed to load save")
		return
		
	coins = config.get_value("Player", "coins")
	print("loaded save with coins:", coins)	
	
func save_config() -> void:
	config.set_value("Player", "coins", coins)
	config.save("user://save.cfg")
	print("saved config!")
	
func _on_coin_change(val : int) -> void:
	coins += val
	print(coins)



# config.set_value("Spawn")

# config.save("user")
