@abstract class_name SnowballBossState
extends Node

var actor: SnowballBoss
var state_name: SnowballBossStateName.Name

func enter() -> void:
	print("Entered state ", state_name)
	pass

func exit() -> void:
	print("Exited state  ", state_name)
	pass

@abstract func setup(new_actor: SnowballBoss) -> void

@abstract func process_physics_frame(delta: float) -> SnowballBossStateName.Name
