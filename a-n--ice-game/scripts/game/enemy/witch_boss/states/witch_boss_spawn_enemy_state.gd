extends WitchBossState
class_name WitchBossSpawnEnemyState

var anim_finished = false

func enter() -> void:
	print("Entered state ", state_name)
	
	anim_finished = false
	$"../../AnimationPlayer".play("summon")
	# spawn enemy
	var dirvec = (Globals.get_game().player.global_position - actor.global_position).normalized() * actor.speed
	var enemyscene = preload("res://scenes/game/enemy/summoned ice block.tscn")
	var enemy : Enemy = enemyscene.instantiate()
	
	var rand_pos = actor.get_teleportation_points()[randi()%4]
	
	enemy.global_position = rand_pos.global_position + dirvec/2
	actor.emit_summon_particle(enemy.global_position)
	actor.get_parent().add_child(enemy)
	var mover : ActionMoverComponent = ActionMoverComponent.new()
	mover.actor = enemy
	
	var rand_theta = randf()*2*PI
	print("LUCK:", actor.luck)
	if (actor.luck <= 0.333):
		print("first")
		enemy.set_collision_mask_value(1, false)
		var movements = [
			actor.speed*Vector2(cos(rand_theta), sin(rand_theta)),
			actor.speed*Vector2(cos(rand_theta+2*PI/3), sin(rand_theta+2*PI/3)),
			actor.speed*Vector2(cos(rand_theta+4*PI/3), sin(rand_theta+4*PI/3))]
		
		for i in range(3):
			var action : MoveAction = MoveAction.new()
			action.displacement = movements[i]
			mover.actions.append(action)
	elif actor.luck >= 0.333 and actor.luck < 0.666:
		print("second")
		enemy.set_collision_mask_value(1, false)
		var movements = [
			actor.speed*Vector2(cos(rand_theta), sin(rand_theta)),
			actor.speed*Vector2(cos(rand_theta+PI/2), sin(rand_theta+PI/2)),
			actor.speed*Vector2(cos(rand_theta+PI), sin(rand_theta+PI)),
			actor.speed*Vector2(cos(rand_theta+3*PI/2), sin(rand_theta+3*PI/2))]
		print(movements)
		for i in range(4):
			var action : MoveAction = MoveAction.new()
			action.displacement = movements[i]
			mover.actions.append(action)
	else:
		print("third")
		
		var action : MoveAction = MoveAction.new()
		action.displacement = dirvec
		mover.actions.append(action)
	actor.get_parent().add_child(mover)
	if (actor.HP <= actor.MAX_HP/2):
		await get_tree().create_timer(1).timeout # 5s delay
	else:
		await get_tree().create_timer(2).timeout 
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
	
