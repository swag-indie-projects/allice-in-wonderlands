extends PlayerState

class_name PlayerDashState

@export var dash_timer: Timer
@export var cooldown_timer: Timer

@export var dash_speed_factor: float
@export var dash_particles: GPUParticles2D

@onready var leave_state: bool = false
@onready var last_saved_time: float = 0.0

func _ready() -> void:
	dash_timer.timeout.connect(func(): leave_state = true)

func enter() -> void:
	super()
	# Means we are in cool down. Don't do anything fancy
	if !cooldown_timer.is_stopped():
		return
	
	#$AnimationPlayer.play("dash")
	
	actor.velocity *= dash_speed_factor
	dash_timer.start()
	dash_particles.emitting = true
	
	dash_particles.rotation = actor.velocity.angle()
	
	leave_state = false
	last_saved_time = 0.0

func exit() -> void:
	super()
	if cooldown_timer.is_stopped():
		cooldown_timer.start()
	actor.dash_progress_bar.modulate = Color("50a1d1ff")

func setup(new_actor: CharacterBody2D) -> void:
	actor = new_actor
	state_name = StateName.Name.DASH

func process_frame(_delta: float) -> StateName.Name:
	#print(cooldown_timer.is_stopped())
	if !cooldown_timer.is_stopped():
		return StateName.Name.WALK
	
	if leave_state == true:
		leave_state = false
		return StateName.Name.WALK
	
	var current_time: float = dash_timer.wait_time - dash_timer.time_left
	if last_saved_time < current_time:
		add_dash_shade()
		last_saved_time += dash_timer.wait_time / 3.0
	
	return state_name

func process_physics_frame(_delta: float) -> StateName.Name:
	return state_name

func add_dash_shade(
		lifetime := 0.18,
		start_alpha := 0.55,
	) -> void:
	# Find a drawable child to duplicate (Sprite2D or AnimatedSprite2D)
	var sprite: AnimatedSprite2D = actor.animation
	# Duplicate the visual node (deep copy so frames/texture refs are kept)
	var shade: CanvasItem = sprite.duplicate(DUPLICATE_USE_INSTANTIATION | DUPLICATE_SCRIPTS) as CanvasItem
	
	var game: Node2D = Globals.get_game()
	game.add_child(shade)
	
	# Match transform in world
	shade.global_position = sprite.global_position
	#if shade is Node2D and src is Node2D:
		#(shade as Node2D).global_rotation = (src as Node2D).global_rotation
		#(shade as Node2D).global_scale = (src as Node2D).global_scale * scale_multiplier
	
	shade.modulate.a = start_alpha
	
	# Tween fade-out then free
	var tw := shade.create_tween()
	tw.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tw.tween_property(shade, "modulate:a", 0.0, lifetime)
	tw.tween_callback(shade.queue_free)
