extends Control

class_name PauseMenu

@onready var main_menu_scene: PackedScene = load(Constant.PATH_TO_MAIN_MENU)
@export var animation_player: AnimationPlayer

func _ready() -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_escape"):
		if get_tree().paused:
			resume()
		else:
			pause()

func pause() -> void:
	get_tree().paused = true
	animation_player.play(&"blur")

func resume() -> void:
	get_tree().paused = false
	animation_player.play_backwards(&"blur")
	
func _on_resume_pressed() -> void:
	resume()

func _on_options_pressed() -> void:
	pass # Replace with function body.

func _on_exit_pressed() -> void:
	get_tree().paused = false
	animation_player.play(&"RESET")
	animation_player.stop()
	get_tree().change_scene_to_packed(main_menu_scene)
