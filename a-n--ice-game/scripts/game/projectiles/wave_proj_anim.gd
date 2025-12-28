extends ProjectileAnimation

@export var proj_scene: PackedScene
@export var bullet_speed: float
@export var shoot_anim_player: AnimationPlayer

func _summon_projectiles(world, target_position, spawn_position):
	self.world = world
	self.direction = spawn_position.direction_to(target_position)
	self.spawn_point = spawn_position
	shoot_anim_player.play("shoot")
	

var world: World
var direction: Vector2
var spawn_point: Vector2

func _test(dirDiff: float) -> void:
	
	var a = proj_scene.instantiate() as SnowballProjectile
	world.add_child(a)
	a.global_position = spawn_point
	a._set_data(direction.rotated(dirDiff / 180 * PI), bullet_speed)
