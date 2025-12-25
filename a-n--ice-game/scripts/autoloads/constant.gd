extends Node

const PLAYER_STARTING_HP: int = 5

# I have to include this because otherwise I will be creating circular dependency.
# So from now on, everytime when the path is changed you have to manually change it here
const PATH_TO_MAIN_MENU: String = "res://scenes/main_menu.tscn"
