extends Area2D

@onready var sprite = $AnimatedSprite2D
@onready var sound = $AudioStreamPlayer
@onready var collided : bool = false

func _ready() -> void:
	sprite.play("default")
	


func _on_body_entered(body: Node2D) -> void:
	if collided == false:
		
		if body is Player:
			self.collided = true
			sound.play()
			var game = Globals.get_game()
			if (game):
				game.shop_ui.setup()
			#await get_tree().create_timer(10.0).timeout # 10s delay before next time its open


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		self.collided = false
