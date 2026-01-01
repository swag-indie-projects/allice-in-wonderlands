extends Area2D

@export var spawnpoint : Constant.Paths

@onready var sprite = $AnimatedSprite2D
@onready var sound = $AudioStreamPlayer

static var opened = false;

func _on_area_entered(body) -> void:
	print(body)
	if (opened == false) and (body is SwordSwipe):
		opened = true
		sprite.play("default")
		sound.play()
		var game = Globals.get_game()
		print("game")
		if (game):
			game.save_manager.update_save_data("spawn", self.spawnpoint)
			game.save_manager.save_game()
			game.player_save_tooltip_ui.show_save_popup()
		#await get_tree().create_timer(10.0).timeout # 10s delay before next time its open

func _on_far_away_detector_area_exited(area: Area2D) -> void:
	sprite.play_backwards("default")
	opened = false
