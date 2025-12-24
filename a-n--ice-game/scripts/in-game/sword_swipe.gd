extends Area2D

class_name SwordSwipe
@export var animation: AnimatedSprite2D
@export var attack_distance: float

var direction_vector: Vector2

func _ready() -> void:
	position = Vector2.ZERO
	hide()
	monitoring = false
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body is Enemy:
		body.get_hit(1, direction_vector)

func swipe() -> void:
	direction_vector = (get_global_mouse_position() - global_position).normalized()
	
	# prevent NaNs if mouse is exactly on top of us
	if direction_vector.length_squared() < 0.000001:
		direction_vector = Vector2.DOWN
	
	# offset the hitbox outwards
	position = direction_vector * attack_distance

	# because your "forward" (down) was rotation = 0
	rotation = direction_vector.angle() - PI / 2
	
	show()
	monitoring = true
	animation.play(&"default")


func _on_animated_sprite_2d_animation_finished() -> void:
	monitoring = false
	hide()
