extends WitchBossState
class_name WitchBossRunState

var anim_finished = false

func enter() -> void:
	print("Entered state ", state_name)
	anim_finished = false
	# calculate difference from player
	
	var dirvec = (actor.global_position - Globals.get_game().player.global_position).normalized()
	if dirvec.dot(Vector2(cos(3*PI/4),sin(3*PI/4))) >= 0 and dirvec.dot(Vector2(cos(1*PI/4), sin(1*PI/4))) >= 0:
		actor.animation_sprite.play("walk_up")
	elif dirvec.dot(Vector2(cos(PI/4), sin(PI/4))) >= 0 and dirvec.dot(Vector2(cos(7*PI/4), sin(7*PI/4))) >= 0:
		actor.animation_sprite.play("walk_right")
	elif dirvec.dot(Vector2(cos(5*PI/4), sin(5*PI/4))) >= 0 and dirvec.dot(Vector2(cos(7*PI/4), sin(7*PI/4))) >= 0:
		actor.animation_sprite.play("walk_down")
	elif dirvec.dot(Vector2(cos(5*PI/4), sin(5*PI/4))) >= 0 and dirvec.dot(Vector2(cos(3*PI/4), sin(3*PI/4))) >= 0:
		actor.animation_sprite.play("walk_left")

	self.actor.velocity = dirvec * self.actor.speed
	await get_tree().create_timer(1.0).timeout # 5s delay
	anim_finished = true
	#actor.animation_sprite.animation_finished.connect(_on_animation_finished)
	
func exit() -> void:
	print("Exited state  ", state_name)
	pass

func setup(new_actor: WitchBoss) -> void:
	self.actor = new_actor
	self.state_name = WitchBossStateName.Name.RUN_AWAY

func process_physics_frame(delta: float) -> WitchBossStateName.Name:
	if (anim_finished):
		return WitchBossStateName.Name.IDLE
	return WitchBossStateName.Name.RUN_AWAY
	
