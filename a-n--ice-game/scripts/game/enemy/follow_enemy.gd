extends Enemy

@export var detection_box: Area2D
@export var speed: float
@export var animation: AnimatedSprite2D
@export var health_bar: ProgressBar

var world: World
var cooldown: float = 0

func _ready() -> void:
	if !get_parent() is World:
		push_error("enemy's parent is not a world node")
		queue_free()
	
	world = get_parent()
	
	health_bar.max_value = MAX_HP

func _physics_process(delta: float) -> void:
	super(delta)
	if cooldown > 0:
		cooldown -= delta
		return
	
	if knockback_component.time_due > 0.0:
		knockback_component.process_physics_frame(delta)
		move_and_slide()
		return
	
	var player: Player = world.player
	if detection_box.overlaps_body(player):
		if !$NavigationAgent2D.is_target_reached():
			var dir = global_position.direction_to($NavigationAgent2D.get_next_path_position())
			velocity = dir * speed
		#velocity = (player.position - position).normalized() * speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func _process(delta: float) -> void:
	super(delta)
	animation.play(&"default")
	
	health_bar.value = HP

	for body in $hitbox.get_overlapping_bodies():
		if body is Player:
			body.get_hit(1)
			cooldown = 0.5

func _on_timer_timeout() -> void:
	$NavigationAgent2D.target_position = world.player.global_position
	
