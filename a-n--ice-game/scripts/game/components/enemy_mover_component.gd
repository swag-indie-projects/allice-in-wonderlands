extends Node
class_name ActionMoverComponent

@export var actor: CharacterBody2D
@export var actions: Array[MoveAction]

@onready var index: int = 0
@onready var target_point: Vector2 = actor.global_position + actions[index].displacement

func _ready() -> void:
	if actions.is_empty():
		return

func _physics_process(_delta: float) -> void:
	var target_vector: Vector2 = target_point - actor.global_position
	var distance: float = target_vector.length()
	
	if distance <= 0.1:
		actor.velocity = Vector2.ZERO
		index += 1
		if index == actions.size():
			index = 0
		
		target_point = actor.global_position + actions[index].displacement
		return
	
	actor.velocity = (target_vector / distance) * actions[index].speed
	actor.move_and_slide()
