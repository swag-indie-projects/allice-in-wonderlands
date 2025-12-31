extends PlayerState

class_name PlayerDoFreezeState

@export var pre_freeze_timer: Timer
@export var freeze_burst_scene: PackedScene

@onready var pre_freeze_ended: bool = true

func enter() -> void:
	super()
	actor.velocity = Vector2.ZERO
	
	pre_freeze_timer.start()
	pre_freeze_ended = false

func exit() -> void:
	super()

func setup(new_actor: Player) -> void:
	actor = new_actor
	state_name = PlayerStateName.Name.DO_FREEZE

func process_frame(_delta: float) -> PlayerStateName.Name:
	if !pre_freeze_ended:
		return state_name
	
	return PlayerStateName.Name.IDLE

func process_physics_frame(_delta: float) -> PlayerStateName.Name:
	if !pre_freeze_ended:
		return state_name
	
	return PlayerStateName.Name.IDLE

func _on_pre_freeze_timer_timeout() -> void:
	var freeze_burst: FreezeBurst = freeze_burst_scene.instantiate()
	Globals.get_game().add_child(freeze_burst)
	freeze_burst.burst()
	pre_freeze_ended = true
