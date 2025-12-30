extends Node

class_name SnowballBossStateMachine

@export var actor: SnowballBoss
@export var starting_state: SnowballBossState
@export var state_dictionary: Dictionary[SnowballBossStateName.Name, SnowballBossState]

var current_state: SnowballBossState

func setup() -> void:
	for key: SnowballBossStateName.Name in state_dictionary:
		state_dictionary[key].setup(actor)
	
	change_state(starting_state)

func change_state(new_state: SnowballBossState) -> void:
	if current_state:
		current_state.exit()
	
	current_state = new_state
	current_state.enter()

func process_frame(delta: float) -> void:
	var new_state: SnowballBossState = state_dictionary[current_state.process_frame(delta)]
	if new_state != current_state:
		change_state(new_state)

func process_physics_frame(delta: float) -> void:
	var new_state: SnowballBossState = state_dictionary[current_state.process_physics_frame(delta)]
	if new_state != current_state:
		change_state(new_state)
	
	actor.move_and_slide()
