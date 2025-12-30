extends Control

class_name DeathMenu

signal on_die

@onready var main_menu_scene: PackedScene = load(Constant.PATH_TO_MAIN_MENU)
#@export var vbox_containing_buttons: VBoxContainer

var in_death_menu: bool

func _ready() -> void:
	
	on_die.connect(_show_death_menu)

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_escape"):
		if get_tree().paused:
			retry()

func _show_death_menu() -> void:
	visible = true
	in_death_menu = true
	
	#for button: Button in vbox_containing_buttons.get_children():
		#button.disabled = false
	
	$AnimationPlayer.play(&"blur")
	print("anin is indeed playing...?")

func _process(delta: float) -> void:
	if in_death_menu:
		get_tree().paused = true

func retry() -> void:
	print("pressed reset")
	$AnimationPlayer.play(&"retry")
	in_death_menu = false

func _on_retry_pressed() -> void:
	retry()
	
func _on_exit_pressed() -> void:
	get_tree().paused = false
	$AnimationPlayer.play(&"RESET")
	$AnimationPlayer.stop()
	get_tree().change_scene_to_packed(main_menu_scene)

func _on_settings_quit() -> void:
	#vbox_containing_buttons.show()
	pass
