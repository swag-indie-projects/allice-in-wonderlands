extends PlayerState

class_name PlayerWalkState

@export var speed: float
@export var walk_audio_player: AudioStreamPlayer2D

func setup(new_actor: CharacterBody2D) -> void:
	actor = new_actor
	state_name = PlayerStateName.Name.WALK

func enter() -> void:
	super()

func exit() -> void:
	super()

func process_frame(_delta: float) -> PlayerStateName.Name:
	var direction_vector: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if Input.is_action_just_pressed("dash"):
		return PlayerStateName.Name.DASH
	
	if direction_vector == Vector2.ZERO:
		return PlayerStateName.Name.IDLE
	
	if !walk_audio_player.playing:
		walk_audio_player.play()
	
	var animation_string: StringName = "walk_" + actor.facing_component.facing_name_dictionary[actor.facing_component.facing]
	actor.play_animation(animation_string)
	
	return PlayerStateName.Name.WALK

func process_physics_frame(_delta: float) -> PlayerStateName.Name:
	#print("player's speed: ", actor.speed)
	var direction_vector: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	actor.velocity = direction_vector * speed
	
	return PlayerStateName.Name.WALK
