extends Node2D

@export var reward: RewardScreen.Reward
@export var reward_icon: Sprite2D

func _ready() -> void:
	# Todo: Check if the reward has already been given
	# If so, then... don't show the icon anymore
	reward_icon.texture = (load(RewardScreen.reward_to_icon[reward]) as CompressedTexture2D)

func _on_alter_reward_giver_body_entered(body: Node2D) -> void:
	if body is Player:
		print("okay giving reward")
		# Todo: Actually make it give the reward
		reward_icon.queue_free()
		body.reward_screen.on_reward.emit(reward)
