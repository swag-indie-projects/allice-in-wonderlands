extends Node

class_name FacingComponent

enum Facing { LEFT = 0, RIGHT = 1, BACKWARD = 2, FORWARD = 3 }

var facing: Facing = Facing.FORWARD

static var facing_name_dictionary: Dictionary[Facing, StringName] = {
	Facing.FORWARD: &"front",
	Facing.LEFT: &"left",
	Facing.RIGHT: &"right",
	Facing.BACKWARD: &"back"
}

static var facing_direction_dictionary: Dictionary[Facing, Vector2] = {
	Facing.FORWARD: Vector2(0, 1),
	Facing.LEFT: Vector2(-1, 0),
	Facing.RIGHT: Vector2(1, 0),
	Facing.BACKWARD: Vector2(0, -1)
}

func update_facing() -> void:
	var direction_vector: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction_vector.x > 0.0:
		facing = Facing.RIGHT
	elif direction_vector.x < 0.0:
		facing = Facing.LEFT
	elif direction_vector.y > 0.0:
		facing = Facing.FORWARD
	elif direction_vector.y < 0.0:
		facing = Facing.BACKWARD

static func get_reverse_facing(original_facing: Facing) -> Facing:
	var result_facing: Facing
	match original_facing:
		Facing.LEFT:
			result_facing = Facing.RIGHT
		Facing.RIGHT:
			result_facing = Facing.LEFT
		Facing.FORWARD:
			result_facing = Facing.BACKWARD
		Facing.BACKWARD:
			result_facing = Facing.FORWARD
	return result_facing
