extends Node
class_name BossManager

@export var boss_health_ui : BossHealthUI

signal boss_killed(boss : Constant.Boss_Enum)

func _ready() -> void:
	boss_killed.connect(_on_boss_killed)

func _on_boss_killed(boss_enum : Constant.Boss_Enum) -> void:
	print("BOSS IS KILLED OK?")
	boss_health_ui.visible = false
	Globals.get_game().save_manager.current_save["bosses_killed"].set(Constant.Boss_Enum.Snowball,true)
	Globals.game.stop_playing_boss_music()

func setup_boss(boss : Constant.Boss_Enum):
	print("BOSS:", boss)
	print(Globals.get_game().save_manager.get_save_data("bosses_killed"))
	
	if Globals.get_game().save_manager.get_save_data("bosses_killed").get(boss) == false:
	
		boss_health_ui.visible = true
		boss_health_ui.boss_icon = boss
		boss_health_ui.update_boss_icon()
	#if ui_animations.has_animation("boss_camera_zoom"):
	#	print("Animation exists")
	#	ui_animations.play("boss_camera_zoom")
	#	print("Is playing: ", ui_animations.is_playing())
	#else:
	#	print("Animation not found!")
