extends Node2D

@export var player: Player
#@export var starting_world_scene_path: Constant.Paths = Constant.Paths.PATH_TO_STARTING_WORLD
@export var debug_world_scene_path: Constant.Paths = Constant.Paths.PATH_TO_TEST_SCENE
@export var debug_mod: bool = false
@export var player_healthbar_ui: PlayerHealthbarUI
@export var player_save_tooltip_ui : SavePopupUI
@export var save_manager : SaveManager


@onready var current_world: World = null


func _ready() -> void:
	player.HP_changed.connect(_on_player_HP_changed)
	save_manager.load_game()
	var saved_world : Constant.Paths = save_manager.get_save_data("spawn")
	
	if debug_mod:
		play_world(load(Constant.path_to_string[debug_world_scene_path]), 0)
		return
	
	play_world(load(Constant.path_to_string[saved_world]), 0)
	Globals.game = self
	
	
func play_world(scene: PackedScene, spawn_point_index: int) -> void:
	if is_instance_valid(current_world):
		current_world.queue_free()
	
	current_world = scene.instantiate()
	
	current_world.exited.connect(_on_world_exited)
	
	current_world.setup(player, spawn_point_index)
	add_child.call_deferred(current_world)

var world_change_debounce = true

func _on_world_exited(result: SpawnResult) -> void:
	if (world_change_debounce):
		world_change_debounce = false
		var target_scene: PackedScene = load(Constant.path_to_string[result.scene_path])
		play_world(target_scene, result.spawnpoint_index)
		await get_tree().create_timer(2.0).timeout
		world_change_debounce = true

func _on_player_HP_changed(HP: int, max_HP: int):
	player_healthbar_ui.update_healthbar.emit(HP, max_HP)
