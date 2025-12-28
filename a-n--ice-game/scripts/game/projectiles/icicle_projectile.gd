extends Node2D

class_name IcicleProjectile

var dir: Vector2
var speed: float
var world: World
var offset: int

@export var is_dropping: bool

@export var animation: AnimationPlayer

var ramp_up = 0.0

func _set_data(world: World, offset: int, new_speed: float):
	self.world = world
	self.offset = offset
	
	speed = new_speed
	animation.play("drop")

func _physics_process(delta: float) -> void:
	if is_dropping:
		ramp_up += delta * 5
		position += Vector2.DOWN * speed * delta * ramp_up
	else:
		position += position.direction_to(world.player.global_position + Vector2.UP * offset) * speed / 8 * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.get_hit(2)
		animation.play("destroy")

func _destroy() -> void:
	queue_free()

func _on_die_timer_timeout() -> void:
	queue_free()
