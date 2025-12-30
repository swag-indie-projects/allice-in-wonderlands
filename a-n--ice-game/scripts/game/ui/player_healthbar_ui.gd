# the code is cursed here

extends Control

class_name PlayerUI
signal update_healthbar(HP: int, max_HP: int)
signal update_coin(coins : int)

@export var HP_shard_full: Texture
@export var HP_shard_empty: Texture
@export var HP_shards: Array[TextureRect]
@export var coins_text : RichTextLabel

# the following two variables will be used in the future
#@onready var current_HP: int = Constant.PLAYER_STARTING_HP
#@onready var current_max_HP: int = Constant.PLAYER_STARTING_HP

func _ready() -> void:
	update_healthbar.connect(_on_healthbar_update)
	update_coin.connect(_on_coin_update)
	update_healthbar.emit(
		Constant.PLAYER_STARTING_HP, 
		Constant.PLAYER_STARTING_HP)
	
	
	for texture_rect: TextureRect in HP_shards:
		texture_rect.texture = HP_shard_full

func _on_healthbar_update(HP: int, _max_HP: int) -> void:
	if (HP > _max_HP):
		return
	for i in range(HP):
		HP_shards[i].texture = HP_shard_full
	for i in range(HP, Constant.PLAYER_STARTING_HP):
		HP_shards[i].texture = HP_shard_empty

func _on_coin_update(coins : int) -> void:
	coins_text.text = str(coins)
