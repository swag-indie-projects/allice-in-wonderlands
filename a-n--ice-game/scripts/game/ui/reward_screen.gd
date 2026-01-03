extends Control

class_name RewardScreen

signal on_reward(reward: Constant.Abilities)

@export var icon: TextureRect
@export var text: RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	on_reward.connect(show_reward_screen)

func show_reward_screen(reward: Constant.Abilities):
	get_tree().paused = true
	$AnimationPlayer.speed_scale = 1
	$AnimationPlayer.play("open")
	print(reward)
	text.text = Constant.reward_to_description[reward]
	icon.texture = (load(Constant.reward_to_icon[reward]) as CompressedTexture2D)

func hide_screen():
	get_tree().paused = false
	$AnimationPlayer.speed_scale = 3
	$AnimationPlayer.play_backwards("open")
