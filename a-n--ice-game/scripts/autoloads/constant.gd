extends Node

const PLAYER_STARTING_HP: int = 5

# I have to include this because otherwise I will be creating circular dependency.
# So from now on, everytime when the path is changed you have to manually change it here
const PATH_TO_MAIN_MENU: String = "res://scenes/main_menu.tscn"

enum Paths {
	PATH_TO_STARTING_WORLD, 
	PATH_TO_BIOME1_WORLD1,
	PATH_TO_BIOME1_WORLD2,
	PATH_TO_BIOME1_WORLD3,
	PATH_TO_BIOME1_WORLD4,
	PATH_TO_BIOME1_WORLD5,
	PATH_TO_TEST_SCENE,
	PATH_TO_BIOME1_ENEMY_BASE,
}

var path_to_string: Dictionary[Paths, String] = {
	Paths.PATH_TO_STARTING_WORLD: "res://scenes/game/world/biome1/starting_world.tscn",
	Paths.PATH_TO_BIOME1_WORLD1: "res://scenes/game/world/biome1/biome1_world1.tscn",
	Paths.PATH_TO_BIOME1_WORLD2: "res://scenes/game/world/biome1/biome1_world2.tscn",
	Paths.PATH_TO_BIOME1_WORLD3: "res://scenes/game/world/biome1/biome1_world3.tscn",
	Paths.PATH_TO_BIOME1_WORLD4: "res://scenes/game/world/biome1/biome1_world4.tscn",
	Paths.PATH_TO_BIOME1_WORLD5: "res://scenes/game/world/biome1/biome1_world5.tscn",
	Paths.PATH_TO_BIOME1_ENEMY_BASE: "res://scenes/game/world/biome1/biome1_world_enemy_camp.tscn",
	Paths.PATH_TO_TEST_SCENE: "res://scenes/game/world/test_world1.tscn",
}

const VIEWPORT_SIZE_X = 1152
const VIEWPORT_SIZE_Y = 648
