extends CharacterBody2D

class_name Enemy

@export var HP = 1
@export var knockback_component: KnockbackComponent
@export var animation_component: AnimationComponent

func _physics_process(_delta: float) -> void:
	pass

func _process(_delta: float) -> void:
	pass

func get_hit(amount: int, direction_vector: Vector2) -> void:
	# if it's knockback animation isn't even half way done, then the attack does not count
	if knockback_component.time_due > knockback_component.knockback_duration / 2:
		return
	
	animation_component.play_hit_flash()
	
	if HP - amount <= 0:
		queue_free()
	
	HP -= amount
	print(self, " HP = ", HP)
	knockback_component.setup(direction_vector)
