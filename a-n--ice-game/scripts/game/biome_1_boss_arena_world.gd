extends World

class_name Boss1Arena
@export var undefeated_upper : TileMapLayer
@export var defeated_upper : TileMapLayer
@export var arena_box : Area2D 


func boss_killed_changes() -> void:
	undefeated_upper.visible = false
	undefeated_upper.collision_enabled = false
	defeated_upper.visible = true
	defeated_upper.collision_enabled = true

func _ready() -> void:
	pass

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
	if Globals.get_game():
		if Globals.get_game().save_manager.current_save["bosses_killed"][Constant.Boss_Enum.Snowball]:
			boss_killed_changes()
			
		else:
			print("boss not yet defeated")
			undefeated_upper.visible = true
			undefeated_upper.collision_enabled = true
			defeated_upper.visible = false
			defeated_upper.collision_enabled = false
			var snowball_boss_scene = preload("res://scenes/game/enemy/boss_snowball.tscn")
			var snowball_boss : SnowballBoss = snowball_boss_scene.instantiate()
			snowball_boss.detection_box = arena_box
			snowball_boss.global_position = arena_box.global_position
			snowball_boss.arena_world = self
			self.add_child(snowball_boss)
			
			

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
