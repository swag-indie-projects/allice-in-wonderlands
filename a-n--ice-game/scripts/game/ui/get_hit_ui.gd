extends Control

class_name GetHitUI

signal get_hit

@export var animation_player: AnimationPlayer

func _ready() -> void:
	animation_player.play(&"RESET")
	get_hit.connect(_on_get_hit)

func _on_get_hit() -> void:
	animation_player.play(&"get hit")
