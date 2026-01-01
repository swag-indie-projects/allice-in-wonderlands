extends Node2D

class_name SnowballProjectile

var dir: Vector2
var speed: float

func _set_data(new_dir: Vector2, new_speed: float):
	dir = new_dir
	speed = new_speed

func _process(delta: float) -> void:
	position += dir * speed * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.get_hit(1)
		queue_free()
	
	if body is TileMapLayer:
		if !(body == Globals.get_game().current_world.overlay_tile):
			queue_free()

func _on_die_timer_timeout() -> void:
	queue_free()
