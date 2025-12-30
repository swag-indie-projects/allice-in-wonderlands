extends Node

class_name PlayerStateMachine

@export var actor: CharacterBody2D
@export var starting_state: PlayerState
@export var state_dictionary: Dictionary[PlayerStateName.Name, PlayerState]

var current_state: PlayerState

func setup() -> void:
	for key: PlayerStateName.Name in state_dictionary:
		state_dictionary[key].setup(actor)
	
	change_state(starting_state)

func change_state(new_state: PlayerState) -> void:
	if current_state:
		current_state.exit()
	
	current_state = new_state
	current_state.enter()

func process_frame(delta: float) -> void:
	var new_state: PlayerState = state_dictionary[current_state.process_frame(delta)]
	if new_state != current_state:
		change_state(new_state)

func process_physics_frame(delta: float) -> void:
	var new_state: PlayerState = state_dictionary[current_state.process_physics_frame(delta)]
	if new_state != current_state:
		change_state(new_state)
	
	actor.move_and_slide()
