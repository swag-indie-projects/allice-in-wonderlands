extends Enemy
class_name SnowballBoss

@export var detection_box: Arena_Box
@export var speed: float
#@export var health_bar: ProgressBar
@export var dmg_particle : GPUParticles2D
@export var death_particle : GPUParticles2D
@export var luck : float
@export var state_machine: SnowballBossStateMachine
#@export var animation_component : AnimationComponent
@export var animation_sprite : AnimatedSprite2D
@export var grow_path : Path2D
#@export var MAX_HP : int
#@onready var HP : int = MAX_HP

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
	#state_machine.process_frame(delta)
	
func _on_attack_hitbox_body_entered(body: Node2D) -> void:
	if (state_machine.current_state == state_machine.state_dictionary[SnowballBossStateName.Name.STUN] or state_machine.current_state == state_machine.state_dictionary[SnowballBossStateName.Name.IDLE]):
		return
	print("some attack entered")
	if body is Player:
		body.get_hit(1)
		
#func _on_self_hitbox_body_entered(body: Node2D) -> void:
#	print("some body is entered")
#	print(body)
#	if body is SwordSwipe:
#		print("sowrd hit")
#		self.get_hit(1, Vector2(0,0))	
	
func get_hit(amount: int, direction_vector: Vector2) -> void:
	
	dmg_particle.restart()
	animation_component.play_hit_flash()
	if self.scale.x >= 1:
		self.scale.x -= 0.1
		self.scale.y -= 0.1
	print("HP: ", self.HP)
	if HP - amount <= 0:
		print("dying")
		self.state_machine.change_state(state_machine.state_dictionary[SnowballBossStateName.Name.END])
		
	HP -= amount
