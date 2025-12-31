extends Node

const PLAYER_STARTING_HP: int = 5

# I have to include this because otherwise I will be creating circular dependency.
# So from now on, everytime when the path is changed you have to manually change it here
const PATH_TO_MAIN_MENU: String = "res://scenes/main_menu.tscn"

enum Boss_Enum {Snowball, Witch}

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
	
	PATH_TO_TEST_SCENE,
}

var path_to_string: Dictionary[Paths, String] = {
	Paths.PATH_TO_STARTING_WORLD: "res://scenes/game/world/biome1/starting_world.tscn",
	Paths.PATH_TO_BIOME1_WORLD1: "res://scenes/game/world/biome1/biome1_world1.tscn",
	Paths.PATH_TO_BIOME1_WORLD2: "res://scenes/game/world/biome1/biome1_world2.tscn",
	Paths.PATH_TO_BIOME1_WORLD3: "res://scenes/game/world/biome1/biome1_world3.tscn",
	Paths.PATH_TO_BIOME1_WORLD4: "res://scenes/game/world/biome1/biome1_world4.tscn",
	
	Paths.PATH_TO_BIOME1_SIDEWORLD1: "res://scenes/game/world/biome1/biome1_sideworld1.tscn",
	Paths.PATH_TO_BIOME1_SIDEWORLD2: "res://scenes/game/world/biome1/biome1_sideworld2.tscn",
	Paths.PATH_TO_BIOME1_SIDEWORLD3: "res://scenes/game/world/biome1/biome1_sideworld3.tscn",
	Paths.PATH_TO_BIOME1_SIDEWORLD4: "res://scenes/game/world/biome1/biome1_sideworld4.tscn",
	
	Paths.PATH_TO_BIOME1_ENEMY_BASE: "res://scenes/game/world/biome1/biome1_world_enemy_camp.tscn",
	Paths.PATH_TO_BIOME1_BOSS_ARENA : "res://scenes/game/world/biome1/biome1_boss_arena.tscn",
	
	Paths.PATH_TO_BIOME2_WORLD1: "res://scenes/game/world/biome2/biome2_world1.tscn",
	Paths.PATH_TO_BIOME2_WORLD2: "res://scenes/game/world/biome2/biome2_world2.tscn",
	Paths.PATH_TO_BIOME2_WORLD3: "res://scenes/game/world/biome2/biome2_world3.tscn",
	Paths.PATH_TO_BIOME2_BOSS_ARENA: "res://scenes/game/world/biome2/biome2_boss_arena.tscn",
	
	Paths.PATH_TO_TEST_SCENE: "res://scenes/game/world/test_world1.tscn",
	
}

const VIEWPORT_SIZE_X = 1152
const VIEWPORT_SIZE_Y = 648
