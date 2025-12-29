extends Enemy

@export var detection_box: Area2D
@export var speed: float

@export var animation: AnimatedSprite2D
@export var health_bar: ProgressBar
@export var death_particle : GPUParticles2D

var world: World

func _ready() -> void:
	if !get_parent() is World:
		push_error("enemy's parent is not a world node")
		queue_free()
	
	world = get_parent()
	
	health_bar.max_value = MAX_HP

func _physics_process(delta: float) -> void:
	super(delta)
	if knockback_component.time_due > 0.0:
		knockback_component.process_physics_frame(delta)
		move_and_slide()
		return
	
	var player: Player = world.player
	if detection_box.overlaps_body(player):
		animation.play(&"run")
		if !$NavigationAgent2D.is_target_reached():
			var dir = global_position.direction_to($NavigationAgent2D.get_next_path_position())
			velocity = dir * speed
		#velocity = (player.position - position).normalized() * speed
	else:
		animation.play(&"default")
		velocity = Vector2.ZERO
	move_and_slide()

func _process(delta: float) -> void:
	super(delta)	
	health_bar.value = HP

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Player:
		body.get_hit(1)
		health_bar.value -= 1


func _on_timer_timeout() -> void:
	$NavigationAgent2D.target_position = world.player.global_position
	
func get_hit(amount: int, direction_vector: Vector2) -> void:
	# if it's knockback animation isn't even half way done, then the attack does not count
	if knockback_component.time_due > knockback_component.knockback_duration / 2:
		return
	
	animation_component.play_hit_flash()
	
	if HP - amount <= 0:
		animation.visible = false
		death_particle.emitting = true
		await get_tree().create_timer(death_particle.lifetime).timeout
		queue_free()
	
	HP -= amount
	knockback_component.setup(direction_vector)
