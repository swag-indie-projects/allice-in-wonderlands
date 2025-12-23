@abstract class_name PlayerState

extends Node

var actor: Player
var state_name: StateName.Name

func enter() -> void:
	#print("Entered state ", state_name)
	pass

func exit() -> void:
	#print("Exited state  ", state_name)
	pass

@abstract func setup(new_actor: Player) -> void

@abstract func process_frame(delta: float) -> StateName.Name

@abstract func process_physics_frame(delta: float) -> StateName.Name
