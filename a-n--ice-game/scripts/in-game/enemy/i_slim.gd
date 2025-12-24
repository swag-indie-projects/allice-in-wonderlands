extends Enemy

@export var detection_box: Area2D
@export var speed: float
@export var animation: AnimatedSprite2D
var world: World

func _ready() -> void:
	if !get_parent() is World:
		push_error("enemy's parent is not a world node")
		queue_free()
	
	world = get_parent()

func _physics_process(delta: float) -> void:
	super(delta)
	#print("knockback_component.time_due = ", knockback_component.time_due)
	if knockback_component.time_due > 0.0:
		knockback_component.process_physics_frame(delta)
		move_and_slide()
		return
	
	var player: Player = world.player
	if detection_box.overlaps_body(player):
		print("here")
		velocity = (player.position - position).normalized() * speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func _process(delta: float) -> void:
	super(delta)
	animation.play(&"default")

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Player:
		body.get_hit(1)
