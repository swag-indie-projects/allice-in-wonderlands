extends Enemy

@export var detection_box: Area2D
@export var speed: float
@export var size : float
@export var animation: AnimatedSprite2D
@export var health_bar: ProgressBar


@export var luck : float
var world: World


func _ready() -> void:
	if !get_parent() is World:
		push_error("enemy's parent is not a world node")
		queue_free()
	
	world = get_parent()
	#health_bar.max_value = MAX_HP

func _process(_delta: float) -> void:
	throw_dice()
	print("lucK: " ,luck)
	print("size: " ,animation.scale)

func throw_dice() -> void:
	luck = randf()
	
func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Player:
		body.get_hit(1)
