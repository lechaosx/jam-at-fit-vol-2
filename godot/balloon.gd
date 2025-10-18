extends RigidBody2D

func cut():
	print_debug("POP!")
	queue_free()

func pop():
	print_debug("POP!")
	queue_free()
