extends SnowballBossState
class_name SnowballBossIdleState

var anim_finished = false

func enter() -> void:
	print("Entered state ", state_name)
	self.actor.velocity = Vector2.ZERO

	anim_finished = false
	if (actor.scale.x >= 2):	
		actor.animation_sprite.play("idle")
	else:
		actor.animation_sprite.play("small_idle")
		actor.animation_sprite.scale.x = 2
		actor.animation_sprite.scale.y = 2
	await get_tree().create_timer(3.0).timeout # 5s delay
	actor.animation_sprite.scale.x = 1
	actor.animation_sprite.scale.y = 1
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
		if (self.actor.scale.x <= 1):
			print("border consol")
			return SnowballBossStateName.Name.GROW_CENTER
		elif (self.actor.scale.x > 1):
			return SnowballBossStateName.Name.TARGET_ROLL
	return SnowballBossStateName.Name.IDLE
