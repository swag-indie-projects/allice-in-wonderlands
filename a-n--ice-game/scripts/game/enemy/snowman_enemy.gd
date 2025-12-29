extends Enemy

# For the projectile enemy!
@export var player_detection_box: Area2D
@export var avoidance_box: Area2D
@export var hysteresis: Area2D
@export var speed: float
@export var animation: AnimatedSprite2D
@export var health_bar: ProgressBar
@export var projectile_animation: ProjectileAnimation

var world: World

var is_shooting: bool
var is_retreating: bool

func _ready() -> void:
	if !get_parent() is World:
		push_error("Enemy's parent is not a world node")
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
	
	if is_retreating:
		if hysteresis.overlaps_body(player):
			# We have to walk AWAY from the player!
			var dir = -global_position.direction_to($NavigationAgent2D.get_next_path_position())
			velocity = dir * speed
		else: 
			is_retreating = false
	elif avoidance_box.overlaps_body(player):
		is_retreating = true
	elif !hysteresis.overlaps_body(player) and player_detection_box.overlaps_body(player):
		if !$NavigationAgent2D.is_target_reached():
			var dir = global_position.direction_to($NavigationAgent2D.get_next_path_position())
			velocity = dir * speed
		#velocity = (player.position - position).normalized() * speed
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()

func _process(delta: float) -> void:
	super(delta)
	
	if !is_shooting:
		if velocity == Vector2.ZERO:
			animation.play(&"default")
		else:
			print("hello?")
			if animation.sprite_frames.has_animation("run"):
				animation.play(&"run")
	
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0
	
	health_bar.value = HP

func _on_timer_timeout() -> void:
	$NavigationAgent2D.target_position = world.player.global_position

func _on_shoot_timer_timeout() -> void:
	if player_detection_box.overlaps_body(world.player):
		$"Shoot Timer/AnimationPlayer".play("shoot")
		is_shooting = true
	
func shoot() -> void:
	projectile_animation._summon_projectiles(world, world.player.global_position, global_position + Vector2(10, -10))
