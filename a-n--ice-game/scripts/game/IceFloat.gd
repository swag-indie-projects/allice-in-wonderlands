extends Area2D

@export var base_overlay_tilemap: TileMapLayer

@export var river_yes_source_id: int = 0
@export var river_no_source_id: int = 1

@export var main_collision_shape: CollisionShape2D
@onready var rect_shape: RectangleShape2D = main_collision_shape.shape as RectangleShape2D

var previous_cell_positions: Array[Vector2i] = []

var mounted_player: Player = null
var last_ice_global_position: Vector2


func _ready() -> void:
	last_ice_global_position = global_position
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _physics_process(_delta: float) -> void:
	var current_cell_positions: Array[Vector2i] = get_cells_in_area()
	
	for cell_position in previous_cell_positions:
		if not current_cell_positions.has(cell_position):
			if base_overlay_tilemap.get_cell_source_id(cell_position) == river_no_source_id:
				var atlas := base_overlay_tilemap.get_cell_atlas_coords(cell_position)
				base_overlay_tilemap.set_cell(cell_position, river_yes_source_id, atlas)
	
	for cell_position in current_cell_positions:
		if base_overlay_tilemap.get_cell_source_id(cell_position) == river_yes_source_id:
			var atlas := base_overlay_tilemap.get_cell_atlas_coords(cell_position)
			base_overlay_tilemap.set_cell(cell_position, river_no_source_id, atlas)
	
	previous_cell_positions = current_cell_positions
	
	if mounted_player != null:
		mounted_player.global_position += global_position - last_ice_global_position
	
	last_ice_global_position = global_position


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		mounted_player = body


func _on_body_exited(body: Node2D) -> void:
	if body == mounted_player:
		mounted_player = null


func _exit_tree() -> void:
	for cell_position in previous_cell_positions:
		if base_overlay_tilemap.get_cell_source_id(cell_position) == river_no_source_id:
			var atlas := base_overlay_tilemap.get_cell_atlas_coords(cell_position)
			base_overlay_tilemap.set_cell(cell_position, river_yes_source_id, atlas)
	previous_cell_positions.clear()


func get_cells_in_area() -> Array[Vector2i]:
	var cell_positions: Array[Vector2i] = []

	var e: Vector2 = rect_shape.extents

	var cell_min := base_overlay_tilemap.local_to_map(
		base_overlay_tilemap.to_local(global_position + Vector2(-e.x, -e.y))
	)
	var cell_max := base_overlay_tilemap.local_to_map(
		base_overlay_tilemap.to_local(global_position + Vector2(e.x, e.y))
	)

	for x in range(cell_min.x, cell_max.x + 1):
		for y in range(cell_min.y, cell_max.y + 1):
			cell_positions.append(Vector2i(x, y))

	return cell_positions
