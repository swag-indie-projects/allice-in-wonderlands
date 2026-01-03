extends Area2D

@export var animation: AnimatedSprite2D
@export var audio_player: AudioStreamPlayer2D

func _ready():
	animation.play("default")
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		audio_player.play()
		await audio_player.finished
		if (Globals.game):
			Globals.game.player.HP_changed.emit(Globals.game.player.HP + 3, Globals.game.player.MAX_HP)
			
			

		queue_free()
