extends Node

var game: Node2D = null

func get_game() -> Node2D:
	if game == null:
		printerr("Global: function get_game: game does not exist")
	
	return game
