extends Node2D

@export var is_on: bool = false
@export var speed: FanSpeed = FanSpeed.Normal
@onready var sprites = $AnimatedSprite2D
enum FanSpeed {Slow, Normal, Fast}
var is_on_prev: bool = is_on

func _ready() -> void:
	set_speed(speed)
	if is_on:
		start()

func _process(delta: float) -> void:
	if is_on != is_on_prev:
		is_on_prev = is_on
		on_off_changed(is_on)

func on_off_changed(current: bool) -> void:
	print_debug("electric/fan: %s" % ["ON" if current else "off"])

func start() -> void:
	is_on = true
	sprites.play("default")

func stop() -> void:
	is_on = false
	sprites.stop()

func set_speed(speed: float) -> void:
	match speed:
		FanSpeed.Slow:
			sprites.speed_scale = 0.5
		FanSpeed.Normal:
			sprites.speed_scale = 1.0
		FanSpeed.Fast:
			sprites.speed_scale = 2.0
