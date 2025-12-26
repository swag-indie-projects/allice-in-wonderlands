extends Node2D

class_name World

@export var spawnpoints: Array[Node2D]
@export var exitpoint_to_scene: Dictionary[Area2D, SpawnResult]

var player: Player
signal exited(result: SpawnResult)

func setup(new_player: Player, spawnpoint_index: int):
	
	if spawnpoint_index >= spawnpoints.size():
		printerr("World: function setup: Invalid spawanpoint_index")
	
	player = new_player
	player.reparent(self)
	player.position = spawnpoints[spawnpoint_index].position
	
	for spawnpoint: Node2D in spawnpoints:
		spawnpoint.hide()
	for exitpoint: Area2D in exitpoint_to_scene.keys():
		exitpoint.body_entered.connect(_on_exitpoint_body_entered.bind(exitpoint))
		exitpoint.hide()

func _on_exitpoint_body_entered(body: Node2D, exitpoint: Area2D) -> void:
	print("Here")
	if !(body is Player):
		return
	exited.emit(exitpoint_to_scene[exitpoint])
