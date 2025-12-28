extends Area2D

@export var animation: AnimatedSprite2D
@export var audio_player: AudioStreamPlayer2D


signal coin_collected

func _ready():
	animation.play("default")
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		coin_collected.emit()
		
		audio_player.play()
		await audio_player.finished
		if (Globals.game):
			Globals.game.save_manager.update_save_data("coins", Globals.game.save_manager.get_save_data("coins") + 1)
		queue_free()
