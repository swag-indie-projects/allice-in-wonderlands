extends Control

@export var illustrations: Array[Texture2D]
@export var texture_rect: TextureRect

@onready var index := 0

func _ready() -> void:
	texture_rect.texture = illustrations[index]

func _on_button_pressed() -> void:
	index += 1
	
	if index < illustrations.size():
		texture_rect.texture = illustrations[index]
	else:
		# add starting the game thing
		pass
