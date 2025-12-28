extends ProjectileAnimation

@export var proj_scene: PackedScene
@export var bullet_speed: float

func _summon_projectiles(world, target_position, spawn_position):
	var a = proj_scene.instantiate() as SnowballProjectile
	world.add_child(a)
	a.global_position = spawn_position
	a._set_data(spawn_position.direction_to(target_position), bullet_speed)
