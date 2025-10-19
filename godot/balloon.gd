extends RigidBody2D

@export var pop_sounds: Array[AudioStream] = []

func cut():
	pop()

func pop():
	print_debug("POP!")
	var player := AudioStreamPlayer.new()
	player.stream = pop_sounds.pick_random()
	player.finished.connect(player.queue_free)
	add_sibling(player)
	player.play()
	queue_free()
