extends Node2D

@export var staticBody: StaticBody2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		print("IN")
		body.collision_mask = 2
		staticBody.collision_layer = 2

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		print("OUT")
		body.collision_mask = 3
		staticBody.collision_layer = 128
