extends Node2D

class_name Game

@export var player: Player
#@export var starting_world_scene_path: Constant.Paths = Constant.Paths.PATH_TO_STARTING_WORLD
@export var debug_world_scene_path: Constant.Paths = Constant.Paths.PATH_TO_TEST_SCENE
@export var debug_spawn_point_index: int = 0
@export var debug_mod: bool = false
@export var player_ui: PlayerUI
@export var player_save_tooltip_ui : SavePopupUI
@export var boss_manager : BossManager
@export var ui_animations : AnimationPlayer
@export var shop_ui : ShopUI

@export var camera: Camera2D

@export var audio_stream_player: AudioStreamPlayer2D

var current_biome : Constant.Biome
var current_world: World = null

var first_load = true

func _ready() -> void:
	Globals.game = self
	player.HP = player.MAX_HP
	SaveManager.load_game_stats()
	var saved_world : Constant.Paths = SaveManager.current_save.spawn
	current_biome = Constant.path_info[saved_world][0]
	if debug_mod:
		#player.get_node("Camera2D").Zoom.x = 0.5
		#player.get_node("Camera2D").Zoom.y = 0.5
		current_biome = Constant.path_info[debug_world_scene_path][0]
		
		play_world(debug_world_scene_path, debug_spawn_point_index) # make louder
	else:
		play_world(saved_world, 0, first_load)
		first_load = false
	play_biome_music()

func reset_game() -> void:
	player.HP = player.MAX_HP
	player_ui.update_healthbar.emit(player.MAX_HP, player.MAX_HP)
	current_world.setup(player, 0)
	Globals.game.player.HP_changed.emit(Globals.game.player.MAX_HP, Globals.game.player.MAX_HP)
	add_child.call_deferred(current_world)
	get_tree().reload_current_scene()
	play_world(SaveManager.current_save.spawn, 0, true)
	apply_camera_border_limit()

func play_world(scene_path: Constant.Paths, spawn_point_index: int, spawning_at_fridge:= false) -> void:
	print("SPAWNING AT FRIDGE", spawning_at_fridge)
	var scene: PackedScene = load(Constant.path_info[scene_path][1])
	if (current_biome != Constant.path_info[scene_path][0]):
		current_biome = Constant.path_info[scene_path][0]
		#await get_tree().create_timer(5.0).timeout # 10s 
		play_biome_music()
	else:
		current_biome = Constant.path_info[scene_path][0]
	
	
	if is_instance_valid(current_world):
		current_world.queue_free()
	
	current_world = scene.instantiate()
	
	current_world.exited.connect(_on_world_exited)
	
	current_world.setup(player, spawn_point_index, spawning_at_fridge)
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
	print("TOP:LIMIT:", camera.limit_top)

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


func play_boss_music(boss: Constant.Boss_Enum) -> void:
	audio_stream_player.stream = load(Constant.boss_to_song[boss])
	audio_stream_player.play()
	pass

func play_biome_music() -> void:
	print("current_biome: ", current_biome)
	print("AAAAAAAAAAAA")
	
	audio_stream_player.stream = load(Constant.biome_to_song[current_biome])
	_on_music__await_timeout()
