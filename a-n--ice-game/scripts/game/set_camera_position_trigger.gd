extends Area2D

@export var focal_node2d: Node2D
@export var lerp_duration: float = 1.0

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.camera.set_constant_position(focal_node2d.global_position, lerp_duration)


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.camera.clear_constant_position()
