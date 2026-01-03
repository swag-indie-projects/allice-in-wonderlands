extends Control

@export var illustrations: Array[Texture2D]
@export var texture_rect: TextureRect
@export var game_scene: PackedScene

@onready var index := 0

func _ready() -> void:
	$AnimationPlayer.play_backwards("finished")
	texture_rect.texture = illustrations[index]

func _on_button_pressed() -> void:
	index += 1

	if index < illustrations.size():
		texture_rect.texture = illustrations[index]
	else:
		if (Globals.get_game()):
			Globals.game.cutscene_manager.end_cutscene()
		# add starting the game thing
		pass
		$AnimationPlayer.play("finished")
		$AnimationPlayer.animation_finished.connect(
			func(_name): get_tree().change_scene_to_packed(game_scene)
		)
