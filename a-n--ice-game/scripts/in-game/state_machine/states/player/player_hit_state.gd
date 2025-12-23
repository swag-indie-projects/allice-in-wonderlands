extends PlayerState

class_name PlayerHitState

@export var knockback_duration: float
@export var knockback: float
var acceleration: float = 0.0
var time_elapsed: float = 0.0
var direction_vector: Vector2

func enter() -> void:
	super()
	time_elapsed = 0.0
	acceleration = 2 * knockback / knockback_duration / knockback_duration
	direction_vector = FacingComponent.facing_direction_dictionary[FacingComponent.get_reverse_facing(actor.facing_component.facing)]
	actor.velocity = acceleration * knockback_duration * direction_vector

func exit() -> void:
	super()

func setup(new_actor: CharacterBody2D) -> void:
	actor = new_actor
	state_name = StateName.Name.HIT

func process_frame(_delta: float) -> StateName.Name:
	if time_elapsed >= knockback_duration:
		return StateName.Name.IDLE
	return state_name

func process_physics_frame(delta: float) -> StateName.Name:
	if time_elapsed >= knockback_duration:
		return StateName.Name.IDLE
	actor.velocity -= acceleration * delta * direction_vector
	time_elapsed += delta
	
	return state_name
