extends World

class_name Boss1Arena
@export var undefeated_upper : TileMapLayer
@export var defeated_upper : TileMapLayer
@export var arena_box : Area2D 

var boss_not_defeated:= false

func boss_killed_changes() -> void:
	undefeated_upper.visible = false
	undefeated_upper.collision_enabled = false
	defeated_upper.visible = true
	defeated_upper.collision_enabled = true

func _ready() -> void:
	pass


func is_boss_defeated():
	return Globals.get_game() and Globals.get_game().save_manager.current_save["bosses_killed"][Constant.Boss_Enum.Snowball]

func setup(new_player: Player, spawnpoint_index: int):
	if spawnpoint_index >= spawnpoints.size():
		printerr("World: function setup: Invalid spawanpoint_index")
	
	player = new_player
	player.reparent(self)
	player.position = spawnpoints[spawnpoint_index].position
	
	for spawnpoint: Node2D in spawnpoints:
		spawnpoint.hide()
	for exitpoint: Area2D in exitpoint_to_scenepath.keys():
		exitpoint.body_entered.connect(_on_exitpoint_body_entered.bind(exitpoint))
		exitpoint.hide()

	# check if boss is defeated
	
	boss_killed_changes()
		# Otherwise we wait for the Start Boss Area to invoke "spawn boss"


func spawn_boss():
	
	Globals.game.boss_manager.setup_boss(Constant.Boss_Enum.Snowball)
	
	
	print("boss not yet defeated")
	boss_not_defeated = true
	undefeated_upper.visible = true
	undefeated_upper.collision_enabled = true
	#defeated_upper.visible = false
	#defeated_upper.collision_enabled = false
	var snowball_boss_scene = preload("res://scenes/game/enemy/boss_snowball.tscn")
	var snowball_boss : SnowballBoss = snowball_boss_scene.instantiate()
	snowball_boss.detection_box = arena_box
	snowball_boss.global_position = arena_box.global_position
	snowball_boss.arena_world = self
	self.add_child.call_deferred(snowball_boss)	

func get_border_rectangle() -> Rect2:
	if base_tile == null:
		push_error("%s: base_tile is null. Scene=%s NodePath=%s"
			% [name, get_tree().current_scene.name, get_path()])
		return Rect2()
	
	var rectangle: Rect2i = base_tile.get_used_rect()
	var tile_size: Vector2 = base_tile.tile_set.tile_size
	
	var top_left_global: Vector2 = base_tile.to_global(Vector2(rectangle.position) * tile_size) 
	var bottom_right_global: Vector2 = base_tile.to_global(Vector2(rectangle.position + rectangle.size) * tile_size)
	
	return Rect2(top_left_global, bottom_right_global - top_left_global)
