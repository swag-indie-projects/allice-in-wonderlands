extends Area2D


var duplicated_shape: CollisionShape2D
@export var ice_float: IceFloat

func _ready() -> void:
	print(ice_float.base_overlay_tilemap)
	# Get the collision shape child
	var collision_shape: CollisionShape2D = $CollisionShape2D
	
	# Duplicate the collision shape
	duplicated_shape = collision_shape.duplicate()
	
	# Extract the number from this Area2D's name (e.g., "Area2D1" -> "1")
	var area_name = name
	var number = area_name.replace("Area2D", "")
	duplicated_shape.name = number
	
	
	# Add to parent (StaticBody2D)
	var parent = get_parent()
	if parent is StaticBody2D:
		parent.add_child.call_deferred(duplicated_shape)
	else:
		push_error("Parent is not a StaticBody2D")

func _process(delta: float) -> void:
	# Check if overlapping with any other Area2D
	
	if get_overlapping_bodies().size() == 0:
		duplicated_shape.disabled = true
		return
	
	var overlapping_areas = get_overlapping_areas()
	
	if overlapping_areas.size() > 0:
		duplicated_shape.disabled = true
	else:
		duplicated_shape.disabled = false
