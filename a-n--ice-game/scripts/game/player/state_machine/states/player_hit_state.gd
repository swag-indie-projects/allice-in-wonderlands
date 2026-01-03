extends PlayerState

class_name PlayerHitState

@export var knockback_duration: float
@export var knockback: float
@export var sound: AudioStreamPlayer2D

var acceleration: float = 0.0
var time_elapsed: float = 0.0
var direction_vector: Vector2

func enter() -> void:
	super()
	
	actor.get_hit_ui.get_hit.emit()
	actor.camera.shaking.emit()
	sound.play()
	
	print(actor.HP)
	if actor.HP == 0:
		actor.death_menu.on_die.emit()
		return

	time_elapsed = 0.0
	acceleration = 2 * knockback / knockback_duration / knockback_duration
	direction_vector = FacingComponent.facing_direction_dictionary[FacingComponent.get_reverse_facing(actor.facing_component.facing)]
	actor.velocity = acceleration * knockback_duration * direction_vector

func exit() -> void:
	super()

func setup(new_actor: CharacterBody2D) -> void:
	actor = new_actor
	state_name = PlayerStateName.Name.HIT

func process_frame(_delta: float) -> PlayerStateName.Name:
	if Input.is_action_just_pressed("dash"):
		if (SaveManager.current_save.abilities_collected.get(Constant.Abilities.Dash)):
			return PlayerStateName.Name.DASH
	if time_elapsed >= knockback_duration:
		return PlayerStateName.Name.IDLE
	return state_name

func process_physics_frame(delta: float) -> PlayerStateName.Name:
	if time_elapsed >= knockback_duration:
		return PlayerStateName.Name.IDLE
	actor.velocity -= acceleration * delta * direction_vector
	time_elapsed += delta
	
	return state_name
