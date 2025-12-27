extends Node2D

@export var player: Player
@export var starting_world_scene_path: Constant.Paths = Constant.Paths.PATH_TO_STARTING_WORLD
@export var test_world_scene_path: Constant.Paths = Constant.Paths.PATH_TO_TEST_SCENE
@export var player_healthbar_ui: PlayerHealthbarUI

@onready var game_state : GameState = $GameState
@onready var current_world: World = null

signal coin_change(val);

func _ready() -> void:
	player.HP_changed.connect(_on_player_HP_changed)
	
	play_world(load(Constant.path_to_string[starting_world_scene_path]), 0)
	Globals.game = self
	
	game_state.load_config() # load game
	get_tree().auto_accept_quit = false # prevent auto close without saving

func _notification(event: int) -> void:
	if event == NOTIFICATION_WM_CLOSE_REQUEST:
		# do save stuff here
		game_state.save_config()
		# quit game
		get_tree().quit()

func play_world(scene: PackedScene, spawn_point_index: int) -> void:
	if is_instance_valid(current_world):
		current_world.queue_free()
	
	current_world = scene.instantiate()
	
	current_world.exited.connect(_on_world_exited)
	
	current_world.setup(player, spawn_point_index)
	add_child.call_deferred(current_world)

func _on_world_exited(result: SpawnResult) -> void:
	var target_scene: PackedScene = load(Constant.path_to_string[result.scene_path])
	play_world(target_scene, result.spawnpoint_index)

func _on_player_HP_changed(HP: int, max_HP: int):
	player_healthbar_ui.update_healthbar.emit(HP, max_HP)
	coin_change.emit(1)
