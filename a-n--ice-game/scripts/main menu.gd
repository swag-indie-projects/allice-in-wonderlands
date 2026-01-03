extends Node2D

@export var game_scene: PackedScene
@export var cutscene_scene: PackedScene

@export var settings: Settings
@export var options: VBoxContainer


func _ready() -> void:
	settings.quit.connect(_on_settings_quit)
	# TODO: Within the save, check if the "finished game" result is true
	# of so, then do these things:
	
	
	if SaveManager.current_save.bosses_killed.get(Constant.Boss_Enum.Witch):
		$CanvasLayer/VBoxContainer/lore.disabled = false
		$CanvasLayer/VBoxContainer/lore.text = "Lore!"

func _on_start_game_pressed() -> void:
	$AnimationPlayer.play("start_game")
	
	var first_cutscene_shown = false
	
	$AnimationPlayer.animation_finished.connect(
		func(name): 
			if !first_cutscene_shown:
				get_tree().change_scene_to_packed(cutscene_scene)
			else:
				get_tree().change_scene_to_packed(game_scene)
	)

func _on_options_pressed() -> void:
	options.hide()
	settings.show()


func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_settings_quit() -> void:
	settings.hide()
	options.show()

func _on_lore_pressed() -> void:
	$CanvasLayer/LORE.visible = true


func _on_lore_leave_pressed() -> void:
	$CanvasLayer/LORE.visible = false


func _on_delete_pressed() -> void:
	
	DirAccess.remove_absolute("user://savegame.tres")
	SaveManager._ready()
	
	var old_text = $CanvasLayer/VBoxContainer/delete.text
	$CanvasLayer/VBoxContainer/delete.text = "Deleted!"
	await get_tree().create_timer(1).timeout
	$CanvasLayer/VBoxContainer/delete.text = old_text
	
