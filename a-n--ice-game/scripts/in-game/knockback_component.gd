extends Node

class_name KnockbackComponent

@export var knockback: float
@export var knockback_duration: float
@export var actor: CharacterBody2D

var direction_vector: Vector2 = Vector2.ZERO
var acceleration: float = 0.0
var time_due: float = 0.0

func setup(knockback_direction_vector: Vector2) -> void:
	direction_vector = knockback_direction_vector.normalized()
	time_due = knockback_duration
	acceleration = 2 * knockback / knockback_duration / knockback_duration
	
	actor.velocity = Vector2.ZERO

func process_physics_frame(delta: float) -> void:
	actor.velocity += acceleration * delta * direction_vector
	time_due -= delta
