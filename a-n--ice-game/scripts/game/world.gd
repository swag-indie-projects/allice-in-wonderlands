extends Node2D

class_name World

@export var spawnpoint: Node2D

var player: Player

func setup(new_player: Player, _spawnpoint_index: int):
	player = new_player
	player.reparent(self)
	player.position = spawnpoint.position
	
	spawnpoint.get_child(0).hide()
