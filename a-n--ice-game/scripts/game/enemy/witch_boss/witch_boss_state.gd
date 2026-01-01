@abstract class_name WitchBossState
extends Node

var actor: WitchBoss
var state_name: WitchBossStateName.Name

func enter() -> void:
	print("Entered state ", state_name)
	pass

func exit() -> void:
	print("Exited state  ", state_name)
	pass

@abstract func setup(new_actor: WitchBoss) -> void

@abstract func process_physics_frame(delta: float) -> WitchBossStateName.Name
