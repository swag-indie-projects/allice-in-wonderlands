extends SnowballBossState
class_name SnowballBossIdleState

var anim_finished = false

func enter() -> void:
	print("Entered state ", state_name)
	self.actor.velocity = Vector2.ZERO

	anim_finished = false
	actor.animation_sprite.play("idle")
	await get_tree().create_timer(3.0).timeout # 5s delay
	anim_finished = true
	#actor.animation_sprite.animation_finished.connect(_on_animation_finished)
	
func exit() -> void:
	print("Exited state  ", state_name)
	pass

func setup(new_actor: SnowballBoss) -> void:
	self.actor = new_actor
	self.state_name = SnowballBossStateName.Name.IDLE

func process_physics_frame(delta: float) -> SnowballBossStateName.Name:
	if (self.actor.HP <= 0):
			return SnowballBossStateName.Name.END
	if anim_finished:
		if (self.actor.HP <= self.actor.MAX_HP/2):
			print("were going to roll!")
			return SnowballBossStateName.Name.TARGET_ROLL
		else:	
			if (self.actor.scale.x <= 1):
				pass
				return SnowballBossStateName.Name.GROW_CENTER
			elif (self.actor.scale.x > 1):
				pass
				return SnowballBossStateName.Name.ROLL
	return SnowballBossStateName.Name.IDLE
