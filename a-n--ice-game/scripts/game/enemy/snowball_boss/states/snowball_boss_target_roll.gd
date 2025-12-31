extends SnowballBossState
class_name SnowballBossTargetRollState

var anim_finished = false
var walls_hit = 0
var walls_max = 5
var accel = 1;
var debounce = true

func enter() -> void:
	print("Entered state ", state_name)
	self.walls_hit = 0
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
	if (self.actor.velocity.length() < self.actor.speed):
		self.actor.velocity = self.actor.velocity.normalized() * self.actor.speed
	if debounce and (self.actor.detection_box.check_outside_boundary(self.actor.global_position +  self.actor.velocity * 0.1 * self.actor.scale.x)):
		debounce = false
		print("wall hit")
		walls_hit += 1
		set_random_velocity()
		
		debounce = true
	
	if walls_hit >= walls_max:
		return SnowballBossStateName.Name.STUN
	return SnowballBossStateName.Name.TARGET_ROLL
