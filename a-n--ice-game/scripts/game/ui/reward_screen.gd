extends Control

class_name RewardScreen

enum Reward {
	DASH,
	FREEZE_SPELL
}

signal on_reward(reward: Reward)

const reward_to_icon: Dictionary[Reward, String] = {
	Reward.DASH: "res://assets/misc/dash_icon.png",
	Reward.FREEZE_SPELL: "bazinga"	
}

const reward_to_description: Dictionary[Reward, String] = {
	Reward.DASH: "Press SHIFT to dash in the direction you're walking!",
	Reward.FREEZE_SPELL: "Press RIGHT CLICK to freeze enemies and water!"
}

@export var icon: TextureRect
@export var text: RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	on_reward.connect(show_reward_screen)

func show_reward_screen(reward: Reward):
	print("SHOWING SCREEEEEN!")
	get_tree().paused = true
	$AnimationPlayer.speed_scale = 1
	$AnimationPlayer.play("open")
	icon.texture = (load(RewardScreen.reward_to_icon[reward]) as CompressedTexture2D)

func hide_screen():
	get_tree().paused = false
	$AnimationPlayer.speed_scale = 3
	$AnimationPlayer.play_backwards("open")
