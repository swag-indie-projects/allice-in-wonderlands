extends Area2D

@export var animation: AnimatedSprite2D
@export var audio_player: AudioStreamPlayer2D

func _ready():
	animation.play("default")
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("update health")
		audio_player.play()
		await audio_player.finished
		
		if (Globals.game):
			print(Globals.game.player.HP)
			print(Globals.game.player.MAX_HP)
			Globals.game.player.HP = min(Globals.game.player.HP+1, Globals.game.player.MAX_HP)
			#player_ui.update_healthbar.emit(player.HP+1, player.MAX_HP)
			Globals.game.player_ui.update_healthbar.emit(Globals.game.player.HP, Globals.game.player.MAX_HP)

		queue_free()
