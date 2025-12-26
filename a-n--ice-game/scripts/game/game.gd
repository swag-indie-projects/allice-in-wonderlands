extends Node2D

@export var player: Player
@export var starting_world_scene: PackedScene
@export var world_scene_test: PackedScene
@export var player_healthbar_ui: PlayerHealthbarUI

@onready var current_world: World = null


func play_world(scene: PackedScene, spawn_point_index: int) -> void:
	if is_instance_valid(current_world):
		current_world.queue_free()
	
	current_world = scene.instantiate()
	
	current_world.exited.connect(_on_world_exited)
	
	current_world.setup(player, spawn_point_index)
	add_child.call_deferred(current_world)

func _ready() -> void:
	player.HP_changed.connect(_on_player_HP_changed)
	
	play_world(starting_world_scene, 0)

func _on_world_exited(result: SpawnResult) -> void:
	play_world(result.scene, result.spawnpoint_index)

func _on_player_HP_changed(HP: int, max_HP: int):
	player_healthbar_ui.update_healthbar.emit(HP, max_HP)
