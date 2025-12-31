extends Node

var game: Game = null

func get_game() -> Game:
	if game == null:
		printerr("Global: function get_game: game does not exist")
	
	return game
