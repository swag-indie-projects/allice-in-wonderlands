extends Node2D
@onready var coin = $Coin

func _ready():
	coin.play("default")

func _process(delta):
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("entered in my body")
	print(body)
	if body is Player:
		# GlobalController.add_coin(1)
		self.queue_free();
