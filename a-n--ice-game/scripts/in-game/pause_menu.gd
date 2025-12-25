extends Control

class_name PauseMenu

@onready var main_menu_scene: PackedScene = load(Constant.PATH_TO_MAIN_MENU)
@export var animation_player: AnimationPlayer
@export var vbox_containing_buttons: VBoxContainer

func _ready() -> void:
	for button: Button in vbox_containing_buttons.get_children():
		button.disabled = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_escape"):
		if get_tree().paused:
			resume()
		else:
			pause()

func pause() -> void:
	for button: Button in vbox_containing_buttons.get_children():
		button.disabled = false
	
	get_tree().paused = true
	animation_player.play(&"blur")

func resume() -> void:
	for button: Button in vbox_containing_buttons.get_children():
		button.disabled = true
	
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
