extends SnowballBossState
class_name SnowballBossGrowBorderState

var anim_finished = false
var theta 
var radius 

func get_velocity() -> Vector2:
	self.theta += PI/2
	self.radius += self.actor.speed * get_physics_process_delta_time() 
	
	return Vector2(self.radius * cos(self.theta), self.radius * sin(self.theta))
	
func enter() -> void:
	print("Entered state ", state_name)
	# calculate the vector from the center of the detection box
	self.radius = self.actor.speed 
	self.theta = 3 * PI/2
	self.actor.velocity = Vector2(self.radius * cos(self.theta), self.radius * sin(self.theta)) * 2
	self.actor.animation_sprite.play("run")
	#actor.animation_sprite.animation_finished.connect(_on_animation_finished)
	
func exit() -> void:
	print("Exited state  ", state_name)
	pass

func setup(new_actor: SnowballBoss) -> void:
	self.actor = new_actor
	self.state_name = SnowballBossStateName.Name.GROW_BORDER

func process_physics_frame(delta: float) -> SnowballBossStateName.Name:
	if (self.actor.velocity.length() < self.actor.speed):
		self.actor.velocity = self.actor.velocity.normalized() * self.actor.speed
	
	if (self.actor.detection_box.check_outside_boundary(self.actor.global_position + self.actor.velocity * 0.1 * self.actor.scale.x )):
		self.actor.velocity = get_velocity()
		print("outside the boundaries")
		
	if (self.theta > 4 * PI):
		return SnowballBossStateName.Name.IDLE
	
	if self.actor.scale.x <= 2:
		self.actor.scale.x += 0.15* delta
		self.actor.scale.y += 0.15 * delta
	
	return SnowballBossStateName.Name.GROW_BORDER
