extends Node2D

@export var player: Player
#@export var starting_world_scene_path: Constant.Paths = Constant.Paths.PATH_TO_STARTING_WORLD
@export var debug_world_scene_path: Constant.Paths = Constant.Paths.PATH_TO_TEST_SCENE
@export var debug_mod: bool = false
@export var player_healthbar_ui: PlayerHealthbarUI
@export var player_save_tooltip_ui : SavePopupUI
@export var save_manager : SaveManager

@export var audio_stream_player: AudioStreamPlayer2D

@onready var current_world: World = null


func _ready() -> void:
	Globals.game = self
	
	player.HP_changed.connect(_on_player_HP_changed)
	save_manager.load_game()
	var saved_world : Constant.Paths = save_manager.get_save_data("spawn")
	print(saved_world)
	
	if debug_mod:
		player.get_node("Camera2D").Zoom.x = 0.5
		player.get_node("Camera2D").Zoom.y = 0.5
		# play_world(load(Constant.path_to_string[debug_world_scene_path]), 0)
		return
	
	play_world(load(Constant.path_to_string[saved_world]), 0)

func play_world(scene: PackedScene, spawn_point_index: int) -> void:
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
		var target_scene: PackedScene = load(Constant.path_to_string[result.scene_path])
		play_world(target_scene, result.spawnpoint_index)
		await get_tree().create_timer(0.5).timeout
		world_change_debounce = true

func _on_player_HP_changed(HP: int, max_HP: int):
	player_healthbar_ui.update_healthbar.emit(HP, max_HP)

func apply_camera_border_limit() -> void:
	var camera := player.get_node("Camera2D") as Camera2D
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
