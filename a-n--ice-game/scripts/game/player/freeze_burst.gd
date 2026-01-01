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

func burst(new_direction_vector: Vector2) -> void:
	self.direction_vector = new_direction_vector
	
	if direction_vector.length_squared() < 0.000001:
		direction_vector = Vector2.DOWN
	
	var impact_point: Vector2 = direction_vector * attack_distance + Globals.get_game().player.global_position
	global_position = impact_point
	attempt_freeze_water_at_point(impact_point)

	
	rotation = direction_vector.angle() - PI / 2
	#animation.play(&"default")
	timer.start()

func _on_timer_timeout() -> void:
	queue_free()

func attempt_freeze_water_at_point(point: Vector2) -> void:
	print("water_hit=", is_water_collision_at_point(point), " point=", point)
	if !is_water_collision_at_point(point):
		return
	
	var world: World = Globals.get_game().current_world
	var tilemap_layer: TileMapLayer = world.overlay_tile
	
	var cell: Vector2i = tilemap_layer.local_to_map(tilemap_layer.to_local(point))
	
	var ice: IceFloat = ice_scene.instantiate() as IceFloat
	ice.base_overlay_tilemap = tilemap_layer
	world.add_child(ice)
	ice.global_position = tilemap_layer.to_global(tilemap_layer.map_to_local(cell))


func is_water_collision_at_point(point: Vector2) -> bool:
	var space: PhysicsDirectSpaceState2D = get_world_2d().direct_space_state
	
	var params: PhysicsPointQueryParameters2D = PhysicsPointQueryParameters2D.new()
	params.position = point
	params.collide_with_areas = true
	params.collide_with_bodies = true
	params.collision_mask = 0x7FFFFFFF
	
	var hits: Array[Dictionary] = space.intersect_point(params, 32)
	print("hits=", hits.size())
	return !hits.is_empty()
