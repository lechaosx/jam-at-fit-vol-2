extends Node2D

@export var is_on: bool = false
@export var speed: FanSpeed = FanSpeed.Normal
@onready var sprites = $AnimatedSprite2D
@onready var connector = $ElectricConnector
enum FanSpeed {Slow, Normal, Fast}
var is_on_prev: bool = is_on

func _ready() -> void:
	set_speed(speed)
	on_off_changed(is_on)
	
	if is_on:
		$AudioStreamPlayer.play()

func _process(_delta: float) -> void:
	if is_on != is_on_prev:
		is_on_prev = is_on
		on_off_changed(is_on)

func on_off_changed(value: bool) -> void:
	print_debug("electric/fan: %s - GFX" % connector.on_off_str(value))
	if value:
		start()
	else:
		stop()

func start() -> void:
	is_on = true
	sprites.play("default")
	$AudioStreamPlayer.play()

func stop() -> void:
	is_on = false
	sprites.stop()
	$AudioStreamPlayer.stop()

func set_speed(speed: FanSpeed) -> void:
	match speed:
		FanSpeed.Slow:
			$AudioStreamPlayer.pitch_scale = 0.5
			sprites.speed_scale = 0.5
		FanSpeed.Normal:
			$AudioStreamPlayer.pitch_scale = 1.0
			sprites.speed_scale = 1.0
		FanSpeed.Fast:
			$AudioStreamPlayer.pitch_scale = 2.0
			sprites.speed_scale = 2.0

	print_debug("electric/fan: speed = %s, value = %f" % [
		FanSpeed.keys()[speed],
		sprites.speed_scale
	])

func _physics_process(delta: float) -> void:
	for body in $Area2D.get_overlapping_bodies():
		if body is RigidBody2D:
			var force: int

			match speed:
				FanSpeed.Slow:
					force = 50
				FanSpeed.Normal:
					force = 100
				FanSpeed.Fast:
					force = 200

			force *= clamp(1 - global_position.distance_to(body.global_position) / 300, 0, 1)

			body.apply_central_force(Vector2(force, 0).rotated(rotation) * sign(scale.x))

func _on_on_off_changed(value: bool) -> void:
	print_debug("electric/fan: connector(%s)" % connector.on_off_str(value))
	is_on = value
