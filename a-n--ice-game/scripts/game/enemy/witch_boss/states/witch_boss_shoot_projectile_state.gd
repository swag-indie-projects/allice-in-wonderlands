extends WitchBossState
class_name WitchBossShootProjectileState


var anim_finished = false

func enter() -> void:
	print("Entered state ", state_name)
	print("FIRE IN THE HOLE")
	anim_finished = false
	actor.animation_sprite.play("cast")
	
	var projectile_scene = preload("res://scenes/game/projectiles/snowball_projectile.tscn")
	var projectile = projectile_scene.instantiate()
	projectile.dir = (Globals.get_game().player.global_position - actor.global_position).normalized() 
	projectile.speed = actor.speed
	projectile.global_position = actor.global_position
	actor.get_parent().add_child(projectile)
	# spawn enemy
	await get_tree().create_timer(1).timeout # 5s delay
	anim_finished = true
	
func exit() -> void:
	print("Exited state  ", state_name)
	pass
	
func setup(new_actor: WitchBoss) -> void:
	self.actor = new_actor
	self.state_name = WitchBossStateName.Name.SHOOT_PROJECTILE

func process_physics_frame(delta: float) -> WitchBossStateName.Name:
	if anim_finished:
		# check player position:
		if (self.actor.global_position - Globals.get_game().player.global_position).length() < 50:
			print("RUN AWAY!!")
			return WitchBossStateName.Name.RUN_AWAY
		return WitchBossStateName.Name.IDLE
	return WitchBossStateName.Name.SHOOT_PROJECTILE
	
