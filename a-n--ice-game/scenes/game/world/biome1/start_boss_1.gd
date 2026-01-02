extends Area2D

@export var boss_1: Boss1Arena

var disable_spawning:= false

func _ready() -> void:
	if boss_1.is_boss_defeated():
		process_mode = Node.PROCESS_MODE_DISABLED

func _on_body_entered(body: Node2D) -> void:
	if disable_spawning: return
	
	if body is Player:
		boss_1.spawn_boss()
		disable_spawning = true
		$AnimationPlayer.play("close")
		
