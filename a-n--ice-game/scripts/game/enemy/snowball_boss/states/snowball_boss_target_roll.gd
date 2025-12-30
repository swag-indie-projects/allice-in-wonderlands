extends SnowballBossState
class_name SnowballBossTargetRollState

var anim_finished = false
var walls_hit = 0
var walls_max = 5
var accel = 4;

func enter() -> void:
	walls_hit = 0
	print("Entered state ", state_name)
	
	set_random_velocity()
	actor.animation_sprite.play("run")
	#actor.animation_sprite.animation_finished.connect(_on_animation_finished)
	
func exit() -> void:
	print("Exited state  ", state_name)
	pass

func set_random_velocity() -> void:
	accel += 0.1
	self.actor.velocity = (Globals.game.player.global_position - self.actor.global_position).normalized() * self.actor.speed * accel
	print("new velocity:", self.actor.velocity)

func setup(new_actor: SnowballBoss) -> void:
	self.actor = new_actor
	self.state_name = SnowballBossStateName.Name.TARGET_ROLL
	

func process_physics_frame(delta: float) -> SnowballBossStateName.Name:
	
	var next_position = self.actor.global_position + self.actor.velocity * delta
	print(self.actor.velocity)
	if (self.actor.velocity.length() <= self.actor.speed or self.actor.detection_box.check_outside_boundary(next_position)):
		print("wall hit")
		walls_hit += 1
		set_random_velocity()
	
	if walls_hit >= walls_max:
		return SnowballBossStateName.Name.STUN
	return SnowballBossStateName.Name.TARGET_ROLL
