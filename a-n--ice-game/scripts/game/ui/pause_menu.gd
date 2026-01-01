extends Control

class_name PauseMenu

@onready var main_menu_scene: PackedScene = load(Constant.PATH_TO_MAIN_MENU)
@export var animation_player: AnimationPlayer
@export var vbox_containing_buttons: VBoxContainer

@onready var in_back_play: bool = false
@export var settings: Settings

func _ready() -> void:
	self.visible = false
	animation_player.animation_finished.connect(_on_animation_player_finished)
	for button: Button in vbox_containing_buttons.get_children():
		button.disabled = true
	settings.quit.connect(_on_settings_quit)

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_escape"):
		if get_tree().paused and visible == false: 
			return
		
		if get_tree().paused:
			resume()
		else:
			pause()

func pause() -> void:
	self.visible = true
	for button: Button in vbox_containing_buttons.get_children():
		button.disabled = false
	
	get_tree().paused = true
	animation_player.play(&"blur")

func resume() -> void:
	self.visible = false
	get_tree().paused = false
	animation_player.play_backwards(&"blur")
	in_back_play = true
	
	settings.quit.emit()

func _on_resume_pressed() -> void:
	resume()

func _on_options_pressed() -> void:
	vbox_containing_buttons.hide()
	settings.show()

func _on_exit_pressed() -> void:
	get_tree().paused = false
	animation_player.play(&"RESET")
	animation_player.stop()
	get_tree().change_scene_to_packed(main_menu_scene)

func _on_animation_player_finished(animation_name: StringName) -> void:
	
	if animation_name != &"blur":
		return
	
	if !in_back_play:
		return
	
	for button: Button in vbox_containing_buttons.get_children():
		button.disabled = true
	in_back_play = false

func _on_settings_quit() -> void:
	vbox_containing_buttons.show()
	settings.hide()
