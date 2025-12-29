extends PlayerState

class_name PlayerDashState

@export var dash_timer: Timer
@export var cooldown_timer: Timer
@export var dash_speed_factor: float
@export var dash_particles: GPUParticles2D

@onready var leave_state: bool = false

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

func exit() -> void:
	super()
	if cooldown_timer.is_stopped():
		cooldown_timer.start()

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
	
	return state_name

func process_physics_frame(_delta: float) -> StateName.Name:
	return state_name
