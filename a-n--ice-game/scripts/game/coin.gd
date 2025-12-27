extends Area2D

@export var animation: AnimatedSprite2D

signal coin_collected

func _ready():
	animation.play("default")

func _physics_process(_delta: float) -> void:
	for body in get_overlapping_bodies():
		if body is Player:
			print("coin: ", self, " is collected")
			coin_collected.emit()
			queue_free()
