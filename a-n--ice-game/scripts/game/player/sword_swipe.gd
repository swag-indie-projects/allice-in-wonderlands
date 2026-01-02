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
	
	if direction_vector.length_squared() < 0.000001:
		direction_vector = Vector2.DOWN
	
	position = direction_vector * attack_distance
	
	rotation = direction_vector.angle() - PI / 2
	
	show()
	monitoring = true
	animation.play(&"default")

func update_range(scale_factor : int):
	self.scale.y = scale_factor

func _on_animated_sprite_2d_animation_finished() -> void:
	monitoring = false
	hide()
