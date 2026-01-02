extends Node2D

class_name Game

@export var player: Player
#@export var starting_world_scene_path: Constant.Paths = Constant.Paths.PATH_TO_STARTING_WORLD
@export var debug_world_scene_path: Constant.Paths = Constant.Paths.PATH_TO_TEST_SCENE
@export var debug_spawn_point_index: int = 0
@export var debug_mod: bool = false
@export var player_ui: PlayerUI
@export var player_save_tooltip_ui : SavePopupUI
@export var save_manager : SaveManager
@export var boss_manager : BossManager
@export var ui_animations : AnimationPlayer
@export var shop_ui : ShopUI

@export var camera: Camera2D

@export var audio_stream_player: AudioStreamPlayer2D

var current_world: World = null

func _ready() -> void:
	Globals.game = self
	save_manager.load_game() # gets data, and sets up UI, stats, etc..
	var saved_world : Constant.Paths = save_manager.get_save_data("spawn")
	if debug_mod:
		#player.get_node("Camera2D").Zoom.x = 0.5
		#player.get_node("Camera2D").Zoom.y = 0.5
		play_world(debug_world_scene_path, debug_spawn_point_index)
		return
	play_world(saved_world, 0)

func reset_game() -> void:
	player.HP = player.MAX_HP
	player_ui.update_healthbar.emit(player.HP, player.MAX_HP)
	current_world.setup(player, 0)
	add_child.call_deferred(current_world)
	get_tree().reload_current_scene()
	apply_camera_border_limit()

func play_world(scene_path: Constant.Paths, spawn_point_index: int) -> void:
	var scene: PackedScene = load(Constant.path_to_string[scene_path])

	if is_instance_valid(current_world):
		current_world.queue_free()
	
	current_world = scene.instantiate()
	
	current_world.exited.connect(_on_world_exited)
	
	current_world.setup(player, spawn_point_index)
	add_child.call_deferred(current_world)
	
	apply_camera_border_limit()

var world_change_debounce = true

func _on_world_exited(result: SpawnResult) -> void:
	if (world_change_debounce):
		world_change_debounce = false
		play_world(result.scene_path, result.spawnpoint_index)
		await get_tree().create_timer(0.5).timeout
		world_change_debounce = true


func apply_camera_border_limit() -> void:
	if camera == null:
		return
	var border_rectangle: Rect2 = current_world.get_border_rectangle()
	camera.limit_left   = int(border_rectangle.position.x)
	camera.limit_top    = int(border_rectangle.position.y)
	camera.limit_right  = int(border_rectangle.position.x + border_rectangle.size.x)
	camera.limit_bottom = int(border_rectangle.position.y + border_rectangle.size.y)

func _on_music__await_timeout() -> void:
	audio_stream_player.volume_db = -20.0
	audio_stream_player.play()

	var tween := create_tween()
	tween.tween_property(
		audio_stream_player,
		"volume_db",
		0.0,
		2.0
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

const boss_to_song: Dictionary[Constant.Boss_Enum, String] = {
	Constant.Boss_Enum.Witch: "res://sounds/ost/await for the none5.mp3",
	Constant.Boss_Enum.Snowball: "res://sounds/ost/snow ball thing4.mp3"
}

func play_boss_music(boss: Constant.Boss_Enum) -> void:
	audio_stream_player.stream = load(boss_to_song[boss])
	audio_stream_player.play()
	pass

enum Biome {
	Biome1,
	Biome2
}

const biome_to_song: Dictionary[Biome, String] = {
	Biome.Biome1: "res://sounds/ost/winter.ogg",
	Biome.Biome2: "res://sounds/ost/path to unknown.mp3"
}

func stop_playing_boss_music() -> void:
	audio_stream_player.stream = load(biome_to_song[Biome.Biome1])
	_on_music__await_timeout()
