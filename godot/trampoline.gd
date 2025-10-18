extends RigidBody2D


func _on_bouncy_area_body_entered(body: Node2D) -> void:
	if not body is RigidBody2D:
		return

	var rel_vel: Vector2 = linear_velocity - body.linear_velocity
	var top_normal := Vector2.UP.rotated(global_rotation)

	body.linear_velocity = rel_vel.bounce(top_normal) * 2.0
