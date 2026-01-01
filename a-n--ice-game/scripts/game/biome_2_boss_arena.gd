extends World
class_name Boss2Arena

@export var undefeated_upper : TileMapLayer
@export var defeated_upper : TileMapLayer
@export var teleport_spots : Array[Node2D]

func boss_killed_changes() -> void:
	undefeated_upper.visible = false
	undefeated_upper.collision_enabled = false
	defeated_upper.visible = true
	defeated_upper.collision_enabled = true
	
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
		if Globals.get_game().save_manager.current_save["bosses_killed"][Constant.Boss_Enum.Witch]:
			boss_killed_changes()
			
		else:
			print("boss not yet defeated")
			undefeated_upper.visible = true
			undefeated_upper.collision_enabled = true
			defeated_upper.visible = false
			defeated_upper.collision_enabled = false
			var witch_boss_scene = preload("res://scenes/game/enemy/boss_witch.tscn")
			var witch_boss : WitchBoss = witch_boss_scene.instantiate()

			witch_boss.arena_world = self
			witch_boss.teleportation_points=self.teleport_spots
			self.add_child(witch_boss)
			
			
