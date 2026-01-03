# the code is cursed here

extends Control

class_name PlayerUI
signal update_healthbar(HP: int, max_HP: int)
signal update_coin(coins : int)

@export var HP_shard_full: Texture
@export var HP_shard_empty: Texture
@export var HP_shards: Array[TextureRect]
@export var coins_text : RichTextLabel
@export var HP_HBox : HBoxContainer
@export var health_texture : TextureRect

# the following two variables will be used in the future
#@onready var current_HP: int = Constant.PLAYER_STARTING_HP
#@onready var current_max_HP: int = Constant.PLAYER_STARTING_HP

func _ready() -> void:
	update_healthbar.connect(_on_healthbar_update)
	update_coin.connect(_on_coin_update)
	update_healthbar.emit(
		Constant.PLAYER_STARTING_HP, 
		Constant.PLAYER_STARTING_HP)

func _process(delta: float) -> void:
	if Globals.get_game().player.global_position.y <= Globals.get_game().camera.limit_top + 50:
		self.modulate.a = 0.5
	else:
		self.modulate.a = 1

func _on_healthbar_update(HP: int, _max_HP: int) -> void:
	if Globals.get_game():
		Globals.get_game().player.HP = HP
		Globals.get_game().player.MAX_HP = _max_HP
	if (HP > _max_HP):
		return
	var children = HP_HBox.get_children()
	for i in range(_max_HP):
		if (i >= children.size()):
			var new_hp_texture : TextureRect = TextureRect.new()
			HP_HBox.add_child(new_hp_texture)
			new_hp_texture.custom_minimum_size = Vector2(50, 50)  # Adjust to your desired shard size
			new_hp_texture.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			new_hp_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE  # Or EXPAND_KEEP_SIZE if you want min size enforced by texture
			
			if (i < HP):
				new_hp_texture.texture = HP_shard_full
			else:
				new_hp_texture.texture = HP_shard_empty
		else:
			if (i < HP):
				children[i].texture = HP_shard_full
			else:
				children[i].texture = HP_shard_empty


func _on_coin_update(coins : int) -> void:
	coins_text.text = str(coins)
