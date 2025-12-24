extends CanvasLayer

@export var healthbar: Control

func _ready() -> void:
	healthbar.show()
	healthbar.position = Vector2(16, 16)
