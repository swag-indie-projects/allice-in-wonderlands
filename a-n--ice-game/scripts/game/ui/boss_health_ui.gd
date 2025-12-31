extends Control
class_name BossHealthUI

signal setup_health(max_HP: int)
signal update_health(HP: int)

@export var boss_icon : Constant.Boss_Enum
@export var snowball_texture : Texture
@export var witch_texture : Texture


@onready var boss_icon_texture : TextureRect = $TextureRect/TextureRect
@onready var progress : TextureProgressBar = $Progress

func _ready():
	self.visible = false
	setup_health.connect(_on_setup_health)
	update_health.connect(_on_update_health)

func update_boss_icon():
	match boss_icon:
		Constant.Boss_Enum.Snowball:
			boss_icon_texture.texture = snowball_texture
		Constant.Boss_Enum.Witch:
			boss_icon_texture.texture = witch_texture
		_:
			pass


func _on_setup_health(max_hp : int):
	progress.max_value = max_hp
	progress.value = max_hp

func _on_update_health(hp: int):
	progress.value = hp
