extends WitchBossState
class_name WitchBossTeleportState

var anim_finished = false

func enter() -> void:
	print("Entered state ", state_name)
	anim_finished = false
	actor.velocity= Vector2.ZERO
	print("TPTP")
	actor.animation_sprite.play("teleport")
	# actor.animation_sprite.animation_finished.connect(_on_animation_finished)
	await get_tree().create_timer(1.0).timeout # 5s delay
	actor.teleport_random()
	anim_finished = true
	
	

func exit() -> void:
	print("Exited state  ", state_name)
	pass

func setup(new_actor: WitchBoss) -> void:
	self.actor = new_actor
	self.state_name = WitchBossStateName.Name.TELEPORT

func process_physics_frame(delta: float) -> WitchBossStateName.Name:
	if anim_finished:
		return WitchBossStateName.Name.IDLE
	return WitchBossStateName.Name.TELEPORT
	
