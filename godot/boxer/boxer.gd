extends Node2D

var is_punched: bool = false

func trigger_me() -> void:
	if not is_punched:
		
		print_debug("boxer/PUNCH >> >> >> ...")
		is_punched = true
		$"go-go-push-me".freeze = false
		$"go-go-push-me".apply_central_impulse(Vector2.LEFT.rotated(global_rotation) * 1000)
	#	aplayer.play("moveToPunch")
		pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_punched:
		return
	print_debug("boxer/collission...")
	trigger_me()
