extends World
class_name Boss2Arena

@export var undefeated_upper : TileMapLayer
@export var defeated_upper : TileMapLayer
@export var teleport_spots : Array[Area2D]

var boss_not_defeated:= false

func boss_killed_changes() -> void:
	undefeated_upper.visible = false
	undefeated_upper.collision_enabled = false
	defeated_upper.visible = true
	defeated_upper.collision_enabled = true

func is_boss_defeated():
	return Globals.get_game() and SaveManager.current_save["bosses_killed"][Constant.Boss_Enum.Witch]

func setup(new_player: Player, spawnpoint_index: int, spawning_at_fridge:= false):
	boss_killed_changes()
	super(new_player, spawnpoint_index, spawning_at_fridge)

func spawn_boss():
	Globals.game.boss_manager.setup_boss(Constant.Boss_Enum.Witch)
	Globals.game.play_boss_music(Constant.Boss_Enum.Witch)

	print("boss not yet defeated")
	undefeated_upper.visible = true
	undefeated_upper.collision_enabled = true
	#defeated_upper.visible = false
	#defeated_upper.collision_enabled = false
	var witch_boss_scene = preload("res://scenes/game/enemy/boss_witch.tscn")
	var witch_boss : WitchBoss = witch_boss_scene.instantiate()

	witch_boss.arena_world = self
	witch_boss.teleportation_points=self.teleport_spots
	self.add_child(witch_boss)
