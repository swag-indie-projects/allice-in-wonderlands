extends Node
class_name CutsceneManager
@export var cutscene2 : Control
@export var cutscene3 : Control
@export var endcredits : Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var current_cutscene : Control

func play_cutscene(cutscene: Control):
	get_tree().paused = true
	current_cutscene = cutscene
	current_cutscene.visible = true

func end_cutscene() -> void:
	get_tree().paused = false
	current_cutscene.visible = false	
	if current_cutscene == cutscene3:
		play_cutscene(endcredits)
	elif current_cutscene == endcredits:
		var main_menu = preload("res://scenes/main_menu.tscn")
		print("About to change scene...")
		print("Scene tree exists: ", get_tree() != null)
		print("Main menu loaded: ", main_menu != null)

		var error = get_tree().change_scene_to_packed(main_menu)
		print("Change scene result: ", error)  # Should print 0 (OK) if successful
	

func play_cutscene_two()->void:
	play_cutscene(self.cutscene2)

func play_cutscene_three()->void:
	play_cutscene(self.cutscene3)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
