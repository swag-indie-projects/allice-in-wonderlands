extends Enemy

# Similar to ice slime but this is for BOAR
@export var player_detection_box: Area2D
@export var dash_detection_box: Area2D
@export var speed: float
@export var dash_speed: float
@export var animation: AnimatedSprite2D
@export var health_bar: ProgressBar
@export var dash_animation: AnimationPlayer

var world: World

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
	
	if is_dashing:
		velocity = dash_dir * dash_speed
	elif dash_detection_box.overlaps_body(player):
		velocity = Vector2.ZERO
		dash_animation.play(&"dash")
	else:
		dash_animation.stop()
		if player_detection_box.overlaps_body(player):
			if !$NavigationAgent2D.is_target_reached():
				var dir = global_position.direction_to($NavigationAgent2D.get_next_path_position())
				velocity = dir * speed
			#velocity = (player.position - position).normalized() * speed
		else:
			velocity = Vector2.ZERO
	
	animation.flip_h = velocity.x > 0
		
	if velocity != Vector2.ZERO:
		animation.play("dashing")
	else:
		animation.play("default")
	move_and_slide()

func _process(delta: float) -> void:
	super(delta)
	
	health_bar.value = HP

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Player:
		body.get_hit(1)

func _on_timer_timeout() -> void:
	if !is_dashing:
		$NavigationAgent2D.target_position = world.player.global_position

var is_dashing: bool = false
var dash_dir: Vector2

func dash() -> void:
	var player: Player = world.player
	dash_dir = global_position.direction_to(player.global_position)
	is_dashing = true

func stop_dash() -> void:
	is_dashing = false
	
