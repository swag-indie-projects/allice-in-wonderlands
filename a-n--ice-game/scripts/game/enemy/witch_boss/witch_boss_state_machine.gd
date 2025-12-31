extends Node

class_name WitchBossStateMachine

@export var actor: WitchBoss
@export var starting_state: WitchBossState
@export var state_dictionary: Dictionary[WitchBossStateName.Name, WitchBossState]

var current_state: WitchBossState

func setup() -> void:

	for key: WitchBossStateName.Name in state_dictionary:
		state_dictionary[key].setup(self.actor)
	
	change_state(starting_state)

func change_state(new_state: WitchBossState) -> void:
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()

func process_physics_frame(delta: float) -> void:
	var new_state: WitchBossState = state_dictionary[current_state.process_physics_frame(delta)]
	if new_state != current_state:
		change_state(new_state)
	
	actor.move_and_slide()
