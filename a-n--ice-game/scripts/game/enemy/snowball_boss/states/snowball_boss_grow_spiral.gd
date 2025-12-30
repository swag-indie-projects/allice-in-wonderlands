extends SnowballBossState
class_name SnowballBossGrowSpiralState

var anim_finished = false
var theta 
var radius 
var theta_change 

func get_velocity() -> Vector2:
	if (self.theta < 30):
		self.theta_change += PI/16 * get_physics_process_delta_time()
		self.theta += (theta_change) * get_physics_process_delta_time() 
	else:
		print(self.radius)
	self.radius += self.actor.speed * get_physics_process_delta_time() 
	
	return Vector2(self.radius * cos(self.theta), self.radius * sin(self.theta))
	
func enter() -> void:
	# calculate the vector from the center of the detection box
	self.radius = sqrt(self.actor.speed)
	self.theta = 0
	self.theta_change = PI/4
	self.actor.animation_sprite.play("run")
	#actor.animation_sprite.animation_finished.connect(_on_animation_finished)
	
func exit() -> void:
	print("Exited state  ", state_name)
	pass

func setup(new_actor: SnowballBoss) -> void:
	self.actor = new_actor
	self.state_name = SnowballBossStateName.Name.GROW_CENTER



func process_physics_frame(delta: float) -> SnowballBossStateName.Name:
	if (self.radius >= 900 or self.actor.detection_box.check_outside_boundary(self.actor.global_position + self.actor.velocity * delta)):
		print("outside the boundaries")
		return SnowballBossStateName.Name.IDLE
	self.actor.velocity = get_velocity()
	if self.actor.scale.x <= 3:
		self.actor.scale.x += 0.15* delta
		self.actor.scale.y += 0.15 * delta
	
	#self.actor.scale.x += 0.01
	#self.actor.scale.y += 0.01
	
	return SnowballBossStateName.Name.GROW_SPIRAL
	
		
