extends PlayerState

class_name PlayerIdleState

func setup(new_actor: CharacterBody2D) -> void:
	actor = new_actor
	state_name = StateName.Name.IDLE

func enter() -> void:
	super()
	actor.velocity = Vector2.ZERO

func exit() -> void:
	super()

func process_frame(_delta: float) -> StateName.Name:
	var animation_string: StringName = actor.facing_component.facing_name_dictionary[actor.facing_component.facing] + "_idle"
	actor.play_animation(animation_string)
	
	var direction_vector: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction_vector == Vector2.ZERO:
		return StateName.Name.IDLE
	
	return StateName.Name.WALK

func process_physics_frame(_delta: float) -> StateName.Name:
	return StateName.Name.IDLE
