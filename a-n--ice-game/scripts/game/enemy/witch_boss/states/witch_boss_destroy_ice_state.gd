extends WitchBossState
class_name WitchBossDestroyIceState

var anim_finished = false

func enter() -> void:
	self.anim_finished = false
	print("Entered state ", state_name)
	print("Crush all ice")
	actor.animation_sprite.play("cast")
	var world: World = Globals.get_game().current_world
	for ice : IceFloat in world.get_tree().get_nodes_in_group("ice_float"):
		if (ice.mounted_player is Player):
			ice.mounted_player.global_position = self.actor.teleportation_points[randi() % 4].global_position
		
		ice.queue_free()
	await get_tree().create_timer(1.0).timeout # 5s delay
	anim_finished = true
	#actor.animation_sprite.animation_finished.connect(_on_animation_finished)
	
func exit() -> void:
	print("Exited state  ", state_name)
	pass

func setup(new_actor: WitchBoss) -> void:
	self.actor = new_actor
	self.state_name = WitchBossStateName.Name.DESTROY_ICE

func process_physics_frame(delta: float) -> WitchBossStateName.Name:
	if self.anim_finished:
		return WitchBossStateName.Name.IDLE
	return WitchBossStateName.Name.DESTROY_ICE
	
