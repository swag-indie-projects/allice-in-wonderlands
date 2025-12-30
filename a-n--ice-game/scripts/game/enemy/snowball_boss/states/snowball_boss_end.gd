extends SnowballBossState
class_name SnowballBossEndState

var anim_finished = false

func enter() -> void:
	print("Entered state ", state_name)

	anim_finished = false
	actor.animation_sprite.play("idle")
	self.actor.death_particle.emitting = true
	print("dooooooing")
	await get_tree().create_timer(1.5).timeout # 5s delay
	anim_finished = true
	#actor.animation_sprite.animation_finished.connect(_on_animation_finished)
	
func exit() -> void:
	print("Exited state  ", state_name)
	pass

func setup(new_actor: SnowballBoss) -> void:
	self.actor = new_actor
	self.state_name = SnowballBossStateName.Name.END

func process_physics_frame(delta: float) -> SnowballBossStateName.Name:
	if anim_finished:
		print("ending")
		self.actor.queue_free()
		
	return SnowballBossStateName.Name.END
