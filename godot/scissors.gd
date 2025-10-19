extends Area2D

@export var smik_sounds: Array[AudioStream] = []

var closed: bool = false

func _on_body_entered(_body: Node2D) -> void:
	if closed:
		return
		
	$AudioStreamPlayer.stream = smik_sounds.pick_random()
	$AudioStreamPlayer.play()
		
	closed = true
		
	%Opened.visible = false
	%Closed.visible = true
	
	for body in %CutArea.get_overlapping_bodies():
		if body.has_method("cut"):
			body.cut()

	%Points.queue_free()

func _on_points_body_entered(body: Node2D) -> void:
	if closed:
		return
		
	if body.has_method("pop"):
		body.pop()
