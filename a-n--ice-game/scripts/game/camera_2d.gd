extends Camera2D

class_name Camera
signal shaking

@export var duration: float = 0.35
@export var strength: Vector2 = Vector2(14, 10)
@export var frequency: float = 28.0
@export var rot_strength: float = 0.035

@export var player: Player

# Shakey stuff
var time_left := 0.0
var phase := 0.0

# For constant camera position stuff
var use_constant_position := false
var constant_target_position := Vector2.ZERO
var lerp_start_position := Vector2.ZERO
var transition_time := 1.0  # 1.0 means "transition complete"
var lerp_duration: float = 1.0

func _ready() -> void:
	shaking.connect(_on_shaking)

func _process(delta: float) -> void:
	# Handle constant position transition
	if use_constant_position:
		if transition_time < 1.0:
			transition_time += delta / lerp_duration
			transition_time = clampf(transition_time, 0.0, 1.0)
			
			var t := _cubic_ease_out(transition_time)
			global_position = lerp_start_position.lerp(constant_target_position, t)
		else:
			global_position = constant_target_position
	else:
		
		if transition_time < 1.0:
			transition_time += delta / lerp_duration
			transition_time = clampf(transition_time, 0.0, 1.0)
			
			var t := _cubic_ease_out(transition_time)
			global_position = constant_target_position.lerp(player.global_position, t)	
		else:
			global_position = player.global_position
	
	# screen shake stuff
	if time_left <= 0.0:
		offset = Vector2.ZERO
		rotation = 0.0
		return
	
	time_left -= delta
	phase += delta * TAU * frequency
	
	var x := time_left / duration
	var amp := x * x
	
	var ox := sin(phase) * strength.x * amp
	var oy := sin(phase * 1.37) * strength.y * amp
	offset = Vector2(ox, oy)
	
	rotation = sin(phase * 1.11) * rot_strength * amp

func _on_shaking() -> void:
	time_left = duration
	phase = 0.0

# Sets the camera to a fixed position
# Useful for dramatic stuff or boss fights
func set_constant_position(target: Vector2, custom_lerp_time: float = 1.0) -> void:
	use_constant_position = true
	constant_target_position = target
	lerp_start_position = global_position
	transition_time = 0.0
	
	lerp_duration = custom_lerp_time

# Makes it so you aren't focused on a constant position anymore
func clear_constant_position() -> void:
	use_constant_position = false
	transition_time = 0.0

# I love cubes
func _cubic_ease_out(t: float) -> float:
	var f := t - 1.0
	return f * f * f + 1.0
