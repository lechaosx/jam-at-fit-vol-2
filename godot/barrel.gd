extends RigidBody2D

func kaboom():
	for body in $Area2D.get_overlapping_bodies():
		if body is RigidBody2D:
			var distance = global_position.distance_to(body.global_position)
			
			var force = 50000000 / (4 * PI * distance * distance)
			
			body.apply_central_impulse(global_position.direction_to(body.global_position) * force)
			
			if body.has_method("pop") and distance < 300:
				body.pop()
	
	queue_free()


func _on_detection_area_body_entered(body: Node2D) -> void:
	print_debug("CONTACT")
	
	var velocity := linear_velocity
	
	if body is RigidBody2D:
		velocity -= body.linear_velocity
		
	print_debug(velocity)
	print_debug(velocity.length())

	if velocity.length() > 50:
		kaboom()
