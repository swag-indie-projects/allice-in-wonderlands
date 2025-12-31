extends Area2D
class_name Arena_Box


@export var collision_shape : CollisionShape2D

func check_outside_boundary(point: Vector2) -> bool:	
	var shape = collision_shape.shape as RectangleShape2D
	var box_center = self.global_position + collision_shape.position
	var half_size = shape.size / 2.0  
	var local_pos = point - box_center
	return abs(local_pos.x) > half_size.x or abs(local_pos.y) > half_size.y

func weak_check_outside_boundary(point: Vector2) -> bool:	
	var shape = collision_shape.shape as RectangleShape2D
	var box_center = self.global_position + collision_shape.position
	var half_size = shape.size / 2.1
	var local_pos = point - box_center
	return abs(local_pos.x) > half_size.x  or abs(local_pos.y) > half_size.y
