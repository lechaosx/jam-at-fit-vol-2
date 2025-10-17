extends Node2D


@export var is_on: bool = false
@export var speed: FanSpeed = FanSpeed.Normal
@onready var sprites = $AnimatedSprite2D
var speed_max: float ## target speed
var speed_limit: float = 0 ## duration[s] when it will reach speed_max
var speed_current: float = 0
enum FanSpeed {Slow, Normal, Fast}

func _ready() -> void:
	set_speed(speed)
	if is_on:
		start()

func _process(delta: float) -> void:
	if is_on && speed_limit >= 0:
		process_speed(delta)

func process_speed(delta: float) -> void:
	speed_current += delta
	if speed_current >= speed_limit:
		speed_limit = -1
		sprites.speed_scale = speed_max

func start() -> void:
	is_on = true
	sprites.play("default")

func stop() -> void:
	is_on = false
	sprites.stop()

func set_speed(speed: FanSpeed, duration: float = 0) -> void:
	match speed:
		FanSpeed.Slow:
			speed_max = 0.5
		FanSpeed.Normal:
			speed_max = 1.0
		FanSpeed.Fast:
			speed_max = 2.0

	speed_current = 0
	speed_limit = duration
