extends Area2D

@onready var sprite = $AnimatedSprite2D
@onready var sound = $AudioStreamPlayer

static var opened = false;

func _ready() -> void:
	sprite.play("default")

func _on_area_entered(body) -> void:
	print(body)
	if body is SwordSwipe:
		opened = true
		sound.play()
		var game = Globals.get_game()
		if (game):
			game.save_manager.save_game()
			game.player_save_tooltip_ui.show_save_popup()
		#await get_tree().create_timer(10.0).timeout # 10s delay before next time its open
