extends WitchBossState
class_name WitchBossShootProjectileState


@export var bullet_speed: float
var anim_finished = false

func spawn_bullet(direction: float) -> void:
	var projectile_scene: PackedScene = preload("res://scenes/game/projectiles/snowball_projectile.tscn")
	var projectile: SnowballProjectile = projectile_scene.instantiate()
	projectile.dir = Vector2(cos(direction), sin(direction))
	projectile.speed = bullet_speed
	projectile.global_position = actor.global_position
	actor.get_parent().add_child(projectile)

func enter() -> void:
	print("Entered state ", state_name)
	print("FIRE IN THE HOLE")
	anim_finished = false
	actor.animation_sprite.play("cast")
	
	for i in range(0, 3):
		spawn_bullet((Globals.get_game().player.global_position - actor.global_position).angle() + i * PI / 6 - PI / 6)
	await get_tree().create_timer(0.5).timeout
	for i in range(0, 3):
		spawn_bullet((Globals.get_game().player.global_position - actor.global_position).angle() + i * PI / 6 - PI / 6)
	await get_tree().create_timer(0.5).timeout
	for i in range(0, 3):
		spawn_bullet((Globals.get_game().player.global_position - actor.global_position).angle() + i * PI / 6 - PI / 6)
	await get_tree().create_timer(0.5).timeout
	anim_finished = true
	
func exit() -> void:
	print("Exited state  ", state_name)
	pass
	
func setup(new_actor: WitchBoss) -> void:
	self.actor = new_actor
	self.state_name = WitchBossStateName.Name.SHOOT_PROJECTILE

func process_physics_frame(delta: float) -> WitchBossStateName.Name:
	if anim_finished:
		# check player position:
		if (self.actor.global_position - Globals.get_game().player.global_position).length() < 50:
			print("RUN AWAY!!")
			return WitchBossStateName.Name.RUN_AWAY
		return WitchBossStateName.Name.IDLE
	return WitchBossStateName.Name.SHOOT_PROJECTILE
	
