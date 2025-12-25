extends Node2D

@export var player: Player
@export var world_scene: PackedScene
@export var world_scene_test: PackedScene
@export var player_healthbar_ui: PlayerHealthbarUI

func play_world(scene: PackedScene, spawn_point: Vector2) -> void:
	var world: World = scene.instantiate()
	world.setup(player, spawn_point)
	add_child(world)

func _ready() -> void:
	player.HP_changed.connect(_on_player_HP_changed)
	
	play_world(world_scene_test, Vector2(60, 60))

func _on_player_HP_changed(HP: int, max_HP: int):
	player_healthbar_ui.update_healthbar.emit(HP, max_HP)
