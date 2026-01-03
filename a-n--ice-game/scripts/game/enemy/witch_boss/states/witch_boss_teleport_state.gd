extends WitchBossState
class_name WitchBossTeleportState

var anim_finished = false

func enter() -> void:
	print("Entered state ", state_name)
	anim_finished = false
	actor.velocity = Vector2.ZERO
	print("TPTP")
	$"../../AnimationPlayer".play("teleport")
	
	# actor.animation_sprite.animation_finished.connect(_on_animation_finished)
	await get_tree().create_timer(1.2).timeout # 5s delay
	actor.teleport_random()
	await get_tree().create_timer(0.8).timeout
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
	
