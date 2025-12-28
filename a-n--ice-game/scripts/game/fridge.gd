extends Area2D

@onready var sprite = $AnimatedSprite2D
@export var spawnpoint : Constant.Paths

static var opened = false;

func _on_area_entered(body) -> void:
	print(body)
	if (opened == false) and (body is SwordSwipe):
		opened = true
		sprite.play("default")
		if (Globals.game):
			Globals.game.save_manager.update_save_data("spawn", self.spawnpoint)
			Globals.game.save_manager.save_game()
			Globals.game.player_save_tooltip_ui.show_save_popup()
		await get_tree().create_timer(10.0).timeout # 10s delay before next time its open
		opened = false
		sprite.frame = 0

			
