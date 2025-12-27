extends Node

class_name MoveObjectComponent

@export var pathfollow: PathFollow2D
@export var progress_speed: float

func _physics_process(delta: float) -> void:
	pathfollow.progress += progress_speed * delta
