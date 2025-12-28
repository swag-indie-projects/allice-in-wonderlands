extends Enemy
# Weeping angel!

@export var detection_box: Area2D
@export var speed: float
@export var animation: AnimatedSprite2D
@export var health_bar: ProgressBar
@export_range(0, 360, 0.1, "radians_as_degrees") var view_spread: float = 0.0

var world: World
var is_looked_at: bool

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
	
	var angle = player.global_position.direction_to(get_global_mouse_position()).angle_to(player.global_position.direction_to(global_position))
	
	is_looked_at = angle < view_spread and angle > -view_spread
	
	if !is_looked_at and detection_box.overlaps_body(player):
		animation.play("run")
		if !$NavigationAgent2D.is_target_reached():
			var dir = global_position.direction_to($NavigationAgent2D.get_next_path_position())
			velocity = dir * speed
		#velocity = (player.position - position).normalized() * speed
	else:
		velocity = Vector2.ZERO
		animation.play("default")
	move_and_slide()

func _process(delta: float) -> void:
	super(delta)
	#animation.play(&"default")
	
	health_bar.value = HP

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Player:
		print("touching plr")
		body.get_hit(1)

func _on_timer_timeout() -> void:
	if !is_looked_at:
		$NavigationAgent2D.target_position = world.player.global_position
	
