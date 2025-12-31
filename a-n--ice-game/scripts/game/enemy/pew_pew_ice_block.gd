extends Enemy

@export var health_bar: ProgressBar
@export var animation: AnimatedSprite2D

@export var bullet_scene: PackedScene

@export var bullet_speed: float
@export var bullet_direction: float

var world: World
var dying: bool = false

func _ready() -> void:
	if !get_parent() is World:
		push_error("Enemy's parent is not a world node")
		queue_free()
	
	if health_bar != null:
		health_bar.max_value = MAX_HP
	rotate(bullet_direction)

func _physics_process(delta: float) -> void:
	super(delta)
	
	if knockback_component != null and knockback_component.time_due > 0.0:
		knockback_component.process_physics_frame(delta)
		move_and_slide()
		return
	
	velocity = Vector2.ZERO
	move_and_slide()

func _process(delta: float) -> void:
	super(delta)
	
	animation.play(&"default")
	
	if health_bar != null:
		health_bar.value = HP

func _on_hitbox_body_entered(body: Node2D) -> void:
	if dying:
		return
	if body is Player:
		body.get_hit(1)

func die() -> void:
	dying = true
	
	queue_free()

func get_hit(amount: int, direction_vector: Vector2) -> void:
	if knockback_component != null and knockback_component.time_due > knockback_component.knockback_duration / 2.0:
		return
	
	if animation_component != null:
		animation_component.play_hit_flash()
	
	if HP - amount <= 0:
		die()
	
	HP -= amount
	
	if knockback_component != null:
		knockback_component.setup(direction_vector)

func _on_timer_timeout() -> void:
	var bullet: SnowballProjectile = bullet_scene.instantiate()
	bullet.global_position = global_position
	bullet._set_data(Vector2(cos(bullet_direction), sin(bullet_direction)), bullet_speed)
	get_parent().add_child(bullet)
