extends CharacterBody2D

class_name Player

# enum Facing { LEFT, RIGHT, BACKWARD, FORWARD }

var MAX_HP: int = Constant.PLAYER_STARTING_HP
var HP: int
var is_invincible: bool

@export var state_machine: PlayerStateMachine
#@export var healthbar_ui: PlayerUI

@export var facing_component: FacingComponent

@export var sword_swipe: SwordSwipe
@export var sword_swipe_timer : Timer
@export var animation: AnimatedSprite2D

@export var get_hit_ui: GetHitUI
@export var death_menu: DeathMenu
@export var reward_screen: RewardScreen

@export var camera: Camera2D

@export var dash_progress_bar: ProgressBar
@export var dash_state: PlayerDashState

signal HP_changed(HP: int, max_HP: int)
@onready var swipeable : bool = true

func _ready() -> void:
	self.HP_changed.connect(_on_player_HP_changed)
	state_machine.setup()
	dash_progress_bar.max_value = dash_state.cooldown_timer.wait_time
	if Globals.get_game():
		print("WE CAN UPDATE THE MAX HEALTH")
		MAX_HP = SaveManager.current_save.MAX_HP
	HP = MAX_HP
	sword_swipe.swipe() # have to do this due to stupid bugs

func _on_player_HP_changed(HP: int, max_HP: int):
	self.HP = HP
	self.MAX_HP = max_HP
	print("self to self..")
	SaveManager.current_save.HP = HP
	Globals.game.player_ui.update_healthbar.emit(HP, max_HP)

func _process(delta: float) -> void:
	facing_component.update_facing()
	print(self.global_position)
	dash_progress_bar.value = dash_state.cooldown_timer.wait_time - dash_state.cooldown_timer.time_left
	if dash_progress_bar.value == dash_progress_bar.max_value:
		dash_progress_bar.modulate = Color("006af8")
	
	state_machine.process_frame(delta)

func _physics_process(delta: float) -> void:
	state_machine.process_physics_frame(delta)
	
	if Input.is_action_just_pressed("mouse_click"):
		if swipeable:
			swipeable = false
			sword_swipe.swipe()
			sword_swipe_timer.start()
		
	# For invincibility frames
	if is_invincible:
		animation.visible = !animation.visible

func play_animation(animation_name: StringName):
	if animation.name != animation_name:
		animation.play(animation_name)

func get_hit(damage: int) -> void:
	if is_invincible:
		return
	
	HP -= damage
	state_machine.change_state.call_deferred(state_machine.state_dictionary[PlayerStateName.Name.HIT])
	HP_changed.emit(HP, MAX_HP)
	
	# The "freeze" when hit
	get_tree().paused = true
	await get_tree().create_timer(0.20).timeout
	get_tree().paused = false
	
	i_frame_start()

func i_frame_start() -> void:
	$invincibility.start()
	is_invincible = true
	$InvincibleParticle.emitting = true

func _on_invincibility_timeout() -> void:
	is_invincible = false
	animation.visible = true
	

func _on_swipe_timer_timeout() -> void:
	self.swipeable = true
