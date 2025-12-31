extends Node2D

class_name World

@export var spawnpoints: Array[Node2D]
@export var exitpoint_to_scenepath: Dictionary[Area2D, SpawnResult]

@export var base_tile: TileMapLayer
@export var overlay_tile: TileMapLayer

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
	for exitpoint: Area2D in exitpoint_to_scenepath.keys():
		exitpoint.body_entered.connect(_on_exitpoint_body_entered.bind(exitpoint))
		exitpoint.hide()

func _on_exitpoint_body_entered(body: Node2D, exitpoint: Area2D) -> void:
	if !(body is Player):
		return
	exited.emit(exitpoint_to_scenepath[exitpoint])

func get_border_rectangle() -> Rect2:
	if base_tile == null:
		push_error("%s: base_tile is null. Scene=%s NodePath=%s"
			% [name, get_tree().current_scene.name, get_path()])
		return Rect2()
	
	var rectangle: Rect2i = base_tile.get_used_rect()
	var tile_size: Vector2 = base_tile.tile_set.tile_size
	
	var top_left_global: Vector2 = base_tile.to_global(Vector2(rectangle.position) * tile_size) 
	var bottom_right_global: Vector2 = base_tile.to_global(Vector2(rectangle.position + rectangle.size) * tile_size)
	
	return Rect2(top_left_global, bottom_right_global - top_left_global)
