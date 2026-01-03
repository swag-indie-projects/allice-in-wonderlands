extends Node2D

@export var game_scene: PackedScene
@export var settings: Settings
@export var options: VBoxContainer

func _ready() -> void:
	settings.quit.connect(_on_settings_quit)
	

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_packed(game_scene)

func _on_options_pressed() -> void:
	options.hide()
	settings.show()


func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_settings_quit() -> void:
	settings.hide()
	options.show()
