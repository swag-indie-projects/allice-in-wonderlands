extends CharacterBody2D

class_name Player

# enum Facing { LEFT, RIGHT, BACKWARD, FORWARD }

var MAX_HP: int = Constant.PLAYER_STARTING_HP
var HP: int
var is_invincible: bool

@export var state_machine: StateMachine
#@export var healthbar_ui: PlayerHealthbarUI

@export var facing_component: FacingComponent

@export var sword_swipe: SwordSwipe

@export var animation: AnimatedSprite2D


signal HP_changed(HP: int, max_HP: int)

func _ready() -> void:
	state_machine.setup()
	
	HP = MAX_HP
	
	sword_swipe.swipe() # have to do this due to stupid bugs

func _process(delta: float) -> void:
	facing_component.update_facing()
	
	state_machine.process_frame(delta)

func _physics_process(delta: float) -> void:
	state_machine.process_physics_frame(delta)
	
	if Input.is_action_just_pressed("mouse_click"):
		sword_swipe.swipe()
		
	# For invincibility frames
	if is_invincible:
		visible = !visible

func play_animation(animation_name: StringName):
	if animation.name != animation_name:
		animation.play(animation_name)

func get_hit(damage: int) -> void:
	if is_invincible:
		return
		
	HP -= damage
	state_machine.change_state.call_deferred(state_machine.state_dictionary[StateName.Name.HIT])
	HP_changed.emit(HP, MAX_HP)

	# The "freeze" when hit
	get_tree().paused = true
	await get_tree().create_timer(0.25).timeout
	get_tree().paused = false
	
	$invincibility.start()
	is_invincible = true


func _on_invincibility_timeout() -> void:
	is_invincible = false
	visible = true
