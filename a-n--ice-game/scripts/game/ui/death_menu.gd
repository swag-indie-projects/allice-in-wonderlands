extends Control

class_name DeathMenu

signal on_die

@onready var main_menu_scene: PackedScene = load(Constant.PATH_TO_MAIN_MENU)
#@export var vbox_containing_buttons: VBoxContainer

var in_death_menu: bool

func _ready() -> void:
	self.visible = false
	on_die.connect(_show_death_menu)

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_escape"):
		if in_death_menu:
			retry()

func _show_death_menu() -> void:
	visible = true
	in_death_menu = true
	
	#for button: Button in vbox_containing_buttons.get_children():
		#button.disabled = false
	
	$AnimationPlayer.play(&"blur")

func _process(delta: float) -> void:
	if in_death_menu:
		get_tree().paused = true

func _on_retry_pressed() -> void:
	retry()

func retry() -> void:
	print("pressed reset!")
	$AnimationPlayer.play(&"retry")

# This is called without the animation player after the screen goes black!
func actually_retry_game() -> void:
	in_death_menu = false
	get_tree().paused = false

	if (Globals.get_game()):
		Globals.get_game().reset_game()

	
func _on_exit_pressed() -> void:
	get_tree().paused = false
	$AnimationPlayer.play(&"RESET")
	
	get_tree().change_scene_to_packed(main_menu_scene)
