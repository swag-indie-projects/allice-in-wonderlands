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
	return Globals.get_game() and SaveManager.current_save["bosses_killed"][Constant.Boss_Enum.Snowball]

func setup(new_player: Player, spawnpoint_index: int, spawning_at_fridge:= false):
	boss_killed_changes()
	super(new_player, spawnpoint_index, spawning_at_fridge)

func spawn_boss():
	
	Globals.game.boss_manager.setup_boss(Constant.Boss_Enum.Snowball)
	Globals.game.play_boss_music(Constant.Boss_Enum.Snowball)
	
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
