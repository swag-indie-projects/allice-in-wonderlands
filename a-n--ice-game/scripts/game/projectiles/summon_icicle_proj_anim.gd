extends ProjectileAnimation

@export var icicle_proj_scene: PackedScene
@export var bullet_speed: float
@export var above_target_offset: int = 100

func _summon_projectiles(world, target_position, _spawn_position):
	var a = icicle_proj_scene.instantiate() as IcicleProjectile
	world.add_child(a)
	a.global_position = target_position + Vector2.UP * above_target_offset
	a._set_data(world, above_target_offset, bullet_speed)
