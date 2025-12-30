extends Node2D
class_name SnowballBoss

@export var MAX_HP : int
@export var detection_box: Area2D
@export var speed: float
#@export var health_bar: ProgressBar
@export var dmg_particle : GPUParticles2D
@export var luck : float
@export var state_machine: SnowballBossStateMachine
@export var animation_component : AnimationComponent


@onready var HP = MAX_HP
var world: World

func _ready() -> void:
	if !get_parent() is World:
		push_error("enemy's parent is not a world node")
		queue_free()
	
	world = get_parent()
	state_machine.setup()

	#health_bar.max_value = MAX_HP

func _physics_process(delta: float) -> void:
	state_machine.process_physics_frame(delta)


func _process(delta: float) -> void:
	luck = randf()
	print("lucK: " ,luck)
	print("size: " ,self.scale)
	state_machine.process_frame(delta)

	
func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Player:
		body.get_hit(1)
		
func get_hit(amount: int, direction_vector: Vector2) -> void:
	dmg_particle.emitting = true
	animation_component.play_hit_flash()
	
	if HP - amount <= 0:
		queue_free()
	
	HP -= amount
