extends SnowballBossState
class_name SnowballBossGrowCenterState

var anim_finished = false

func set_normalized_vector() -> void:
	var center_vector = self.actor.detection_box.global_position
	var current_vector = self.actor.global_position
	var normalized_vector = (center_vector-current_vector).normalized() * self.actor.speed * 0.75
	self.actor.velocity = normalized_vector
	
func enter() -> void:
	# calculate the vector from the center of the detection box
	set_normalized_vector()
	self.actor.animation_sprite.play("run")
	#actor.animation_sprite.animation_finished.connect(_on_animation_finished)
	
func exit() -> void:
	print("Exited state  ", state_name)
	pass

func setup(new_actor: SnowballBoss) -> void:
	self.actor = new_actor
	self.state_name = SnowballBossStateName.Name.GROW_CENTER

func process_physics_frame(delta: float) -> SnowballBossStateName.Name:
	set_normalized_vector()
	if (self.actor.global_position - self.actor.detection_box.global_position).length() < self.actor.speed/4:
		print("end o tha road")
		return SnowballBossStateName.Name.GROW_BORDER
	return SnowballBossStateName.Name.GROW_CENTER
		
