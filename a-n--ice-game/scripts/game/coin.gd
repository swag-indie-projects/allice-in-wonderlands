extends Area2D

@export var animation: AnimatedSprite2D
@export var audio_player: AudioStreamPlayer2D
@export var type : CoinEnum

enum CoinEnum {Gold, Silver}

var coinsvalue : Dictionary[CoinEnum, int] = {
	CoinEnum.Gold : 3,
	CoinEnum.Silver : 1,
}

signal coin_collected

func _ready():
	if self.type == CoinEnum.Gold:
		animation.play("gold")
	if self.type == CoinEnum.Silver:
		animation.play("silver")
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		coin_collected.emit()
		
		audio_player.play()
		await audio_player.finished
		
		if (Globals.game):
			Globals.game.save_manager.update_save_data("coins", Globals.game.save_manager.get_save_data("coins") + coinsvalue[self.type])
			Globals.game.player_ui.update_coin.emit(Globals.game.save_manager.get_save_data("coins"))
		queue_free()
