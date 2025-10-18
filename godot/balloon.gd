extends RigidBody2D

func cut():
	print_debug("POP!")
	visible = false
	$Pop1.finished.connect(queue_free)
	$Pop1.play()

func pop():
	print_debug("POP!")
	visible = false
	$Pop2.finished.connect(queue_free)
	$Pop2.play()
