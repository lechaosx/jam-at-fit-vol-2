extends Node2D


@export var is_on: bool = false
@onready var sprites = $AnimatedSprite2D


func start() -> void:
	is_on = true
	sprites.play("default")

func stop() -> void:
	is_on = false
	sprites.stop()
