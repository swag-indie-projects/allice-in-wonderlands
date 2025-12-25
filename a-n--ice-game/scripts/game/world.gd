extends Node2D

class_name World

var player: Player

func setup(new_player: Player, player_spawn_point: Vector2):
	player = new_player
	player.reparent(self)
	player.position = player_spawn_point
