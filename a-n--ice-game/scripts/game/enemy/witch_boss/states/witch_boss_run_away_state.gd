extends WitchBossState
class_name WitchBossRunState

var anim_finished = false

func enter() -> void:
	print("Entered state ", state_name)
	self.actor.velocity = Vector2.ZERO

	anim_finished = false
	if (actor.scale.x >= 2):	
		actor.animation_sprite.play("idle")
	await get_tree().create_timer(3.0).timeout # 5s delay
	anim_finished = true
	#actor.animation_sprite.animation_finished.connect(_on_animation_finished)
	
func exit() -> void:
	print("Exited state  ", state_name)
	pass

func setup(new_actor: WitchBoss) -> void:
	self.actor = new_actor
	self.state_name = WitchBossStateName.Name.IDLE

func process_physics_frame(delta: float) -> WitchBossStateName.Name:
	return WitchBossStateName.Name.RUN_AWAY
	
