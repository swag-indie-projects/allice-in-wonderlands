extends Node

class_name AnimationComponent

@export var target_animation: AnimatedSprite2D

var hit_flash_tw: Tween

func play_hit_flash() -> void:
	if target_animation == null:
		return
	
	if hit_flash_tw and hit_flash_tw.is_running():
		hit_flash_tw.kill()
	
	target_animation.modulate = Color(1, 1, 1, 1)
	
	hit_flash_tw = create_tween()
	hit_flash_tw.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	hit_flash_tw.tween_property(target_animation, "modulate", Color(2.2, 2.2, 2.2, 1), 0.06)
	hit_flash_tw.tween_property(target_animation, "modulate", Color(1, 1, 1, 1), 0.10)
