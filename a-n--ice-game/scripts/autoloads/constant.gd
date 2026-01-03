extends Node

const PLAYER_STARTING_HP: int = 5
const PLAYER_STARTING_COINS : int = 60
const PLAYER_STARTING_SWORD_SCALE : int = 1
# I have to include this because otherwise I will be creating circular dependency.
# So from now on, everytime when the path is changed you have to manually change it here
const PATH_TO_MAIN_MENU: String = "res://scenes/main_menu.tscn"

enum Boss_Enum {Snowball, Witch}

enum Abilities {
	Dash,
	Freeze
}

enum Biome {
	Biome1,
	Biome2,
	Test
}

const biome_to_song: Dictionary[Biome, String] = {
	Biome.Biome1: "res://sounds/ost/winter.ogg",
	Biome.Biome2: "res://sounds/ost/path to unknown.mp3"
}

enum Paths {
	PATH_TO_STARTING_WORLD, 
	PATH_TO_BIOME1_WORLD1,
	PATH_TO_BIOME1_WORLD2,
	PATH_TO_BIOME1_WORLD3,
	PATH_TO_BIOME1_WORLD4,
	PATH_TO_BIOME1_WORLD5,
	
	PATH_TO_BIOME1_SIDEWORLD1,
	PATH_TO_BIOME1_SIDEWORLD2,
	PATH_TO_BIOME1_SIDEWORLD3,
	PATH_TO_BIOME1_SIDEWORLD4,
	
	PATH_TO_BIOME1_ENEMY_BASE,
	PATH_TO_BIOME1_BOSS_ARENA,
	
	PATH_TO_BIOME2_WORLD1,
	PATH_TO_BIOME2_WORLD2,
	PATH_TO_BIOME2_WORLD3,
	PATH_TO_BIOME2_BOSS_ARENA,
	
	PATH_TO_BIOME1_ALTER_ROOM,
	PATH_TO_BIOME2_ALTER_ROOM,
	
	PATH_TO_TEST_SCENE,
}

const boss_to_song: Dictionary[Constant.Boss_Enum, String] = {
	Constant.Boss_Enum.Witch: "res://sounds/ost/await for the none5.mp3",
	Constant.Boss_Enum.Snowball: "res://sounds/ost/snow ball thing4.mp3"
}


var path_info: Dictionary[Paths, Array] = {
	Paths.PATH_TO_STARTING_WORLD: [Biome.Biome1,"res://scenes/game/world/biome1/starting_world.tscn"],
	Paths.PATH_TO_BIOME1_WORLD1: [Biome.Biome1,"res://scenes/game/world/biome1/biome1_world1.tscn",],
	Paths.PATH_TO_BIOME1_WORLD2: [Biome.Biome1,"res://scenes/game/world/biome1/biome1_world2.tscn"],
	Paths.PATH_TO_BIOME1_WORLD3: [Biome.Biome1,"res://scenes/game/world/biome1/biome1_world3.tscn"],
	Paths.PATH_TO_BIOME1_WORLD4: [Biome.Biome1, "res://scenes/game/world/biome1/biome1_world4.tscn"],
		
	Paths.PATH_TO_BIOME1_SIDEWORLD1: [Biome.Biome1, "res://scenes/game/world/biome1/biome1_sideworld1.tscn"],
	Paths.PATH_TO_BIOME1_SIDEWORLD2: [Biome.Biome1, "res://scenes/game/world/biome1/biome1_sideworld2.tscn"],
	Paths.PATH_TO_BIOME1_SIDEWORLD3: [Biome.Biome1, "res://scenes/game/world/biome1/biome1_sideworld3.tscn"],
	Paths.PATH_TO_BIOME1_SIDEWORLD4: [Biome.Biome1,"res://scenes/game/world/biome1/biome1_sideworld4.tscn"],
	
	Paths.PATH_TO_BIOME1_ENEMY_BASE: [ Biome.Biome1, "res://scenes/game/world/biome1/biome1_world_enemy_camp.tscn"],
	Paths.PATH_TO_BIOME1_BOSS_ARENA : [Biome.Biome1,"res://scenes/game/world/biome1/biome1_boss_arena.tscn"],
	
	Paths.PATH_TO_BIOME1_ALTER_ROOM: [Biome.Biome1,"res://scenes/game/world/biome1/biome1_alter_room.tscn"],
	
	Paths.PATH_TO_BIOME2_WORLD1: [Biome.Biome2, "res://scenes/game/world/biome2/biome2_world1.tscn"],
	Paths.PATH_TO_BIOME2_WORLD2: [Biome.Biome2, "res://scenes/game/world/biome2/biome2_world2.tscn"],
	Paths.PATH_TO_BIOME2_WORLD3: [Biome.Biome2,"res://scenes/game/world/biome2/biome2_world3.tscn"],
	Paths.PATH_TO_BIOME2_BOSS_ARENA: [Biome.Biome2, "res://scenes/game/world/biome2/biome2_boss_arena.tscn"],
		
	Paths.PATH_TO_BIOME2_ALTER_ROOM: [Biome.Biome2, "res://scenes/game/world/biome2/biome2_alter_room.tscn"],
	
	Paths.PATH_TO_TEST_SCENE: [Biome.Test,"res://scenes/game/world/test_world1.tscn"],
}

const VIEWPORT_SIZE_X = 1152
const VIEWPORT_SIZE_Y = 648
