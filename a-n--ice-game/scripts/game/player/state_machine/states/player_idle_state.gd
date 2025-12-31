extends PlayerState

class_name PlayerIdleState

func setup(new_actor: CharacterBody2D) -> void:
	actor = new_actor
	state_name = PlayerStateName.Name.IDLE

func enter() -> void:
	super()
	actor.velocity = Vector2.ZERO

func exit() -> void:
	super()

func process_frame(_delta: float) -> PlayerStateName.Name:
	if Input.is_action_just_pressed("mouse_click_right"):
		return PlayerStateName.Name.DO_FREEZE
	
	var animation_string: StringName = "idle_" + actor.facing_component.facing_name_dictionary[actor.facing_component.facing]
	actor.play_animation(animation_string)
	
	var direction_vector: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction_vector == Vector2.ZERO:
		return PlayerStateName.Name.IDLE
	
	return PlayerStateName.Name.WALK

func process_physics_frame(_delta: float) -> PlayerStateName.Name:
	return PlayerStateName.Name.IDLE
