extends Node2D

@export var creaks: Array[AudioStream] = []

var creak_threshold := 0.3       # how much angular speed before creaking
var creak_volume_scale := 2.0    # how fast volume scales with angular speed

func _physics_process(delta: float) -> void:
	var ang_vel = abs($RigidBody2D.angular_velocity)

	if ang_vel > creak_threshold and not $AudioStreamPlayer.playing:
		_play_creak(ang_vel)

func _play_creak(ang_vel: float) -> void:
	# Volume proportional to how fast it’s rotating
	var vol = clamp((ang_vel - creak_threshold) * creak_volume_scale, 0.0, 1.0)
	$AudioStreamPlayer.volume_db = linear_to_db(vol)
	$AudioStreamPlayer.pitch_scale = randf_range(0.9, 1.1)
	$AudioStreamPlayer.stream = creaks.pick_random()
	$AudioStreamPlayer.play()
