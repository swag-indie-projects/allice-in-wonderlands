extends WitchBossState
class_name WitchBossEndState

var anim_finished = false

func enter() -> void:
	print("Entered state ", state_name)
	
	actor.animation_sprite.play("idle")
	for ice in Globals.get_game().current_world.get_tree().get_nodes_in_group("ice_block_enemy"):
		ice.queue_free()
	actor.death_particle.emitting = true	
	await get_tree().create_timer(3.0).timeout # 5s delay
	anim_finished = true
	actor.queue_free()
	#actor.animation_sprite.animation_finished.connect(_on_animation_finished)
	
func exit() -> void:
	print("Exited state  ", state_name)
	pass

func setup(new_actor: WitchBoss) -> void:
	self.actor = new_actor
	self.state_name = WitchBossStateName.Name.END

func process_physics_frame(delta: float) -> WitchBossStateName.Name:
	return WitchBossStateName.Name.END
	
