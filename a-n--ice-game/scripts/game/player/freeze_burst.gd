extends Area2D

class_name FreezeBurst
#@export var animation: AnimatedSprite2D
@export var attack_distance: float
@export var timer: Timer

@export var water_tileset_id: int

@export var ice_scene: PackedScene

var direction_vector: Vector2

func _ready() -> void:
	position = Vector2.ZERO
	body_entered.connect(_on_body_entered)

func _process(_delta: float) -> void:
	pass

func _on_body_entered(body: Node) -> void:
	if body is Enemy:
		body.get_hit(1, direction_vector)

func burst(direction_vector: Vector2) -> void:
	self.direction_vector = direction_vector
	
	if direction_vector.length_squared() < 0.000001:
		direction_vector = Vector2.DOWN
	
	global_position = direction_vector * attack_distance + Globals.get_game().player.global_position
	
	attempt_freeze_water()
	
	rotation = direction_vector.angle() - PI / 2
	#animation.play(&"default")
	timer.start()

func _on_timer_timeout() -> void:
	queue_free()

func attempt_freeze_water() -> void:
	var world: World = Globals.get_game().current_world
	
	var tilemap_layer: TileMapLayer = world.overlay_tile
	
	var cell: Vector2i = tilemap_layer.local_to_map(tilemap_layer.to_local(global_position))
	if tilemap_layer.get_cell_source_id(cell) != water_tileset_id:
		return
	
	# Spawn ice aligned to the cell
	var ice: IceFloat = ice_scene.instantiate()
	ice.base_overlay_tilemap = tilemap_layer
	world.add_child(ice)
	
	ice.global_position = tilemap_layer.to_global(tilemap_layer.map_to_local(cell))
