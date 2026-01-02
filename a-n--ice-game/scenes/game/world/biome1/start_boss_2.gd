extends Area2D

@export var boss_2: Boss2Arena

var disable_spawning:= false

func _ready() -> void:
	$"../CanvasLayer/FIGHT Animation".animation_finished.connect(on_anim_finished)
	if boss_2.is_boss_defeated():
		process_mode = Node.PROCESS_MODE_DISABLED

func _on_body_entered(body: Node2D) -> void:
	if disable_spawning: return
	
	if body is Player:
		boss_2.spawn_boss()
		disable_spawning = true
		$AnimationPlayer.play("close")
		$"../CanvasLayer/FIGHT Animation".play("FIGHT!")
		get_tree().paused = true

func on_anim_finished(name: StringName):
	if name == "FIGHT!":
		get_tree().paused = false	
