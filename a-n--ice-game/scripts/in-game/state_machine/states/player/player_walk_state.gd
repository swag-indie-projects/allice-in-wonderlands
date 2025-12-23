extends PlayerState

class_name PlayerWalkState

@export var speed: float

func setup(new_actor: CharacterBody2D) -> void:
	actor = new_actor
	state_name = StateName.Name.WALK

func enter() -> void:
	super()

func exit() -> void:
	super()

func process_frame(_delta: float) -> StateName.Name:
	var direction_vector: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if direction_vector == Vector2.ZERO:
		return StateName.Name.IDLE
	
	var animation_string: StringName = actor.facing_component.facing_name_dictionary[actor.facing_component.facing] + "_idle" # change this to walk once you got it
	actor.play_animation(animation_string)
	
	return StateName.Name.WALK

func process_physics_frame(delta: float) -> StateName.Name:
	#print("player's speed: ", actor.speed)
	var direction_vector: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	actor.velocity = direction_vector * speed
	
	return StateName.Name.WALK
