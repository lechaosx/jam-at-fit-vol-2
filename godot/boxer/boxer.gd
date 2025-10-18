extends Node2D

@onready var spriteIdle = $"globe-start"
@onready var spritePunch = $"glove-end"
@onready var aplayer = $AnimationPlayer
var is_punched: bool = false

func trigger_me() -> void:
	print_debug("boxer/PUNCH >> >> >> ...")
	is_punched = true
	aplayer.play("moveToPunch")
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_punched:
		return
	print_debug("boxer/collission...")
	trigger_me()
