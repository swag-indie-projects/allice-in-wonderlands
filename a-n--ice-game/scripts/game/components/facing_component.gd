extends Node
class_name FacingComponent

enum Facing { LEFT, RIGHT, BACKWARD, FORWARD, FORWARD_LEFT, FORWARD_RIGHT, BACKWARD_LEFT, BACKWARD_RIGHT }

@export var player : Player

var facing: Facing = Facing.FORWARD


static var facing_name_dictionary: Dictionary[Facing, StringName] = {
	Facing.FORWARD: &"front",
	Facing.LEFT: &"left",
	Facing.RIGHT: &"right",
	Facing.BACKWARD: &"back",
	Facing.FORWARD_LEFT: &"front_left",
	Facing.FORWARD_RIGHT: &"front_right",
	Facing.BACKWARD_LEFT: &"back_left",
	Facing.BACKWARD_RIGHT: &"back_right"
}

static var facing_direction_dictionary: Dictionary[Facing, Vector2] = {
	Facing.FORWARD: Vector2(0, 1),
	Facing.LEFT: Vector2(-1, 0),
	Facing.RIGHT: Vector2(1, 0),
	Facing.BACKWARD: Vector2(0, -1),
	Facing.FORWARD_LEFT: Vector2(-1, 1),
	Facing.FORWARD_RIGHT: Vector2(1, 1),
	Facing.BACKWARD_LEFT: Vector2(-1, -1),
	Facing.BACKWARD_RIGHT: Vector2(1, -1)
}

func update_facing() -> void:
	var character_position: Vector2 = Globals.get_game().player.global_position
	
	var mouse_pos: Vector2 = Globals.game.get_global_mouse_position()
	
	var direction_vector: Vector2 = (mouse_pos - character_position).normalized()
	
	
	# Calculate angle from character to mouse (-PI to PI)
	var angle: float = direction_vector.angle()
	
	
	# Convert angle to 8 directions
	# Divide circle into 8 segments (45 degrees each)
	var segment: int = int(round(angle / (PI / 4.0))) % 8
	
	match segment:
		0:  # Right
			facing = Facing.RIGHT
		1:  # Forward-Right
			facing = Facing.BACKWARD_RIGHT
		2:  # Forward
			facing = Facing.FORWARD
		3:  # Forward-Left
			facing = Facing.BACKWARD_LEFT
		4, -4:  # Left
			facing = Facing.LEFT
		-3:  # Backward-Left
			facing = Facing.FORWARD_LEFT
		-2:  # Backward
			facing = Facing.BACKWARD
		-1:  # Backward-Right
			facing = Facing.FORWARD_RIGHT

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
		Facing.FORWARD_LEFT:
			result_facing = Facing.BACKWARD_RIGHT
		Facing.FORWARD_RIGHT:
			result_facing = Facing.BACKWARD_LEFT
		Facing.BACKWARD_LEFT:
			result_facing = Facing.FORWARD_RIGHT
		Facing.BACKWARD_RIGHT:
			result_facing = Facing.FORWARD_LEFT
	return result_facing
