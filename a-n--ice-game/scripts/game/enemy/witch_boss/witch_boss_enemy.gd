extends Enemy
class_name WitchBoss

@export var detection_box: Arena_Box
@export var teleportation_points: Array[Area2D]
@export var arena_world : World
@export var speed: float
@export var dmg_particle : GPUParticles2D
@export var death_particle : GPUParticles2D
@export var summon_particle : GPUParticles2D
@export var luck : float
@export var state_machine: WitchBossStateMachine
@export var animation_sprite : AnimatedSprite2D
#@export var MAX_HP : int
#@onready var HP : int = MAX_HP

var world: World
var tp_position : int = 0

func _ready() -> void:
	if !get_parent() is World:
		push_error("enemy's parent is not a world node")
		queue_free()
	world = get_parent()
	state_machine.setup()
	# setup the ui elements
	self.global_position = self.teleportation_points[tp_position].global_position
	Globals.get_game().boss_manager.boss_health_ui.setup_health.emit(self.MAX_HP)

func teleport_random() :
	var newpos = randi() % 4
	print("TELEPORTING")
	if newpos == tp_position:
		newpos = (tp_position+1) % 4
	tp_position = newpos
	self.global_position = self.teleportation_points[tp_position].global_position

func count_spawns() -> int:
	return Globals.get_game().current_world.get_tree().get_nodes_in_group("ice_block_enemy").size()

func count_ice() -> int:
	return Globals.get_game().current_world.get_tree().get_nodes_in_group("ice_float").size()


func _physics_process(delta: float) -> void:
	state_machine.process_physics_frame(delta)

func _process(delta: float) -> void:
	print(self.global_position)
	luck = randf()

func get_hit(amount: int, direction_vector: Vector2) -> void:
	if HP - amount <= 0:
		print("dying")
		Globals.get_game().boss_manager.boss_killed.emit(Constant.Boss_Enum.Witch)
		arena_world.boss_killed_changes()
		self.state_machine.change_state(state_machine.state_dictionary[WitchBossStateName.Name.END])
	if (self.state_machine.current_state == self.state_machine.state_dictionary[WitchBossStateName.Name.TELEPORT]):
		return
	dmg_particle.restart()
	animation_component.play_hit_flash()
	
	self.state_machine.change_state(self.state_machine.state_dictionary[WitchBossStateName.Name.TELEPORT])
	Globals.game.boss_manager.boss_health_ui.update_health.emit(self.HP)
	
	HP -= amount

func emit_summon_particle(position : Vector2):
	self.summon_particle.global_position = position
	self.summon_particle.emitting = true
	
	
func get_teleportation_points():
	#var copy = []
	#
	#for a in teleportation_points:
		#if !a.get_overlapping_bodies().any(func(item): item == world.player):
			#copy.append(a)
	#print(copy)
	return teleportation_points
