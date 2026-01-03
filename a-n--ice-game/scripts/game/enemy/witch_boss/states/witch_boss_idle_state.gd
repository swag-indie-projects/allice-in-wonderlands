extends WitchBossState
class_name WitchBossIdleState

var anim_finished = false

func enter() -> void:
	self.anim_finished = false
	print("Entered state ", state_name)
	actor.velocity = Vector2.ZERO
	
	actor.animation_sprite.flip_h = actor.global_position.direction_to(Globals.game.player.global_position).x > 0
	
	actor.animation_sprite.play("idle")
	await get_tree().create_timer(0.5).timeout # 5s delay
	anim_finished = true
	
	
func exit() -> void:
	print("Exited state  ", state_name)
	pass

func setup(new_actor: WitchBoss) -> void:

	self.actor = new_actor
	self.state_name = WitchBossStateName.Name.IDLE


func process_physics_frame(delta: float) -> WitchBossStateName.Name:
	if self.actor.velocity != Vector2.ZERO:
		actor.velocity = Vector2.ZERO
	if anim_finished:
		if self.actor.HP >= self.actor.MAX_HP/2:
			if ( self.actor.count_spawns() <= 6):
				return WitchBossStateName.Name.SPAWN_ENEMY
			else:
				return WitchBossStateName.Name.RUN_AWAY
		else:
			if self.actor.luck <= 0.333 and self.actor.count_spawns() <= 10:
				return WitchBossStateName.Name.SPAWN_ENEMY
			elif self.actor.luck > 0.333 and self.actor.luck <= 0.666 and self.actor.count_ice() >= 0:
				return WitchBossStateName.Name.DESTROY_ICE
			else:
				return WitchBossStateName.Name.SHOOT_PROJECTILE
	return WitchBossStateName.Name.IDLE
