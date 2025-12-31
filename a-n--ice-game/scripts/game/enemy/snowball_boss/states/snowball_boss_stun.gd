extends SnowballBossState
class_name SnowballBossStunState

var anim_finished = false

func enter() -> void:
	print("Entered state ", state_name)
	self.actor.velocity = Vector2(0,0)
	anim_finished = false
	actor.animation_sprite.play("stun")
	await get_tree().create_timer(6.0).timeout 
	anim_finished = true
	print("finished this ajimat")
	
	#actor.animation_sprite.animation_finished.connect(_on_animation_finished)
	
func exit() -> void:
	print("Exited state  ", state_name)
	pass

func setup(new_actor: SnowballBoss) -> void:
	self.actor = new_actor
	self.state_name = SnowballBossStateName.Name.STUN

func process_physics_frame(delta: float) -> SnowballBossStateName.Name:
	self.actor.velocity = Vector2(0,0)
	if (self.actor.HP <= 0):
		return SnowballBossStateName.Name.END
	if (anim_finished):
		return SnowballBossStateName.Name.IDLE
	return SnowballBossStateName.Name.STUN
