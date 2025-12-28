extends Camera2D

signal shaking

@export var duration: float = 0.35
@export var strength: Vector2 = Vector2(14, 10)
@export var frequency: float = 28.0
@export var rot_strength: float = 0.035

var time_left := 0.0
var phase := 0.0

func _ready() -> void:
	shaking.connect(_on_shaking)

func _process(delta: float) -> void:
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
