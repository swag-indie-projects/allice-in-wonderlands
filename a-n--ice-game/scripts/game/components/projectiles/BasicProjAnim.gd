extends ProjectileAnimation

@export var proj_scene: PackedScene
@export var bullet_speed: float

func _summon_projectiles(world, direction, spawn_point):
	print("HELO")
	
	var a = proj_scene.instantiate() as SnowballProjectile
	world.add_child(a)
	a.global_position = spawn_point
	a._set_data(direction, bullet_speed)
