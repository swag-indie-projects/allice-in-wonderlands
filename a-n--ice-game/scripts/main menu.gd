extends Node2D

@export var game_scene: PackedScene

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_packed(game_scene)


func _on_exit_pressed() -> void:
	get_tree().quit()
