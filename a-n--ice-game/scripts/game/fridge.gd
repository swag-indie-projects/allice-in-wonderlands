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
