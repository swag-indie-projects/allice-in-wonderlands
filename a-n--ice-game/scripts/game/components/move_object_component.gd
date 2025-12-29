extends Node

class_name MoveObjectComponent

@export var pathfollows: Array[PathFollow2D]
@export var progress_speeds: Array[float]

func _ready():
	for i in range(pathfollows.size()):
		print(pathfollows[i].get_parent().curve.get_baked_length())



func _physics_process(delta: float) -> void:
	for i in range(pathfollows.size()):
		pathfollows[i].progress += progress_speeds[i] * delta
