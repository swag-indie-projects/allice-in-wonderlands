extends Area2D

class_name SwordSwipe
@export var animation: AnimatedSprite2D
@export var attack_distance: float
var facing: FacingComponent.Facing = FacingComponent.Facing.FORWARD

func _ready() -> void:
	position = Vector2.ZERO
	hide()
	monitoring = false
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body is Enemy:
		body.get_hit(1, FacingComponent.facing_direction_dictionary[facing])

func swipe(new_facing: FacingComponent.Facing) -> void:
	var offset: Vector2
	match new_facing:
		FacingComponent.Facing.LEFT:
			offset = Vector2(-attack_distance, 0)
			rotation = PI / 2
		FacingComponent.Facing.RIGHT:
			offset = Vector2(attack_distance, 0)
			rotation = -PI / 2
		FacingComponent.Facing.BACKWARD:
			offset = Vector2(0, -attack_distance)
			rotation = PI
		FacingComponent.Facing.FORWARD:
			offset = Vector2(0, attack_distance)
			rotation = 0
	position = offset
	
	show()
	facing = new_facing
	monitoring = true
	animation.play(&"default")

func _on_animated_sprite_2d_animation_finished() -> void:
	monitoring = false
	hide()
