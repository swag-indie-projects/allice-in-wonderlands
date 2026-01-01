extends WitchBossState
class_name WitchBossSpawnEnemyState

var anim_finished = false

func enter() -> void:
	print("Entered state ", state_name)

	anim_finished = false
	actor.animation_sprite.play("cast")
	# spawn enemy
	
	await get_tree().create_timer(2).timeout # 5s delay
	anim_finished = true
	
func exit() -> void:
	print("Exited state  ", state_name)
	pass

func setup(new_actor: WitchBoss) -> void:
	self.actor = new_actor
	self.state_name = WitchBossStateName.Name.SPAWN_ENEMY

func process_physics_frame(delta: float) -> WitchBossStateName.Name:
	if anim_finished:
		# check player position:
		if (self.actor.global_position - Globals.get_game().player.global_position).length() < 50:
			print("RUN AWAY!!")
			return WitchBossStateName.Name.RUN_AWAY
		return WitchBossStateName.Name.IDLE
	return WitchBossStateName.Name.SPAWN_ENEMY
	
