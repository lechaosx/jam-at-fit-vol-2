extends Node2D

@onready var spriteEmpty = $"Sprite2D-empty"
@onready var spriteConnected = $"Sprite2D-connected"
var is_connected: bool = false

func connect_cable() -> void:
	spriteEmpty.visible = false
	spriteConnected.visible = true
	is_connected = true

func disconnect_cable() -> void:
	spriteEmpty.visible = true
	spriteConnected.visible = false
	is_connected = false
