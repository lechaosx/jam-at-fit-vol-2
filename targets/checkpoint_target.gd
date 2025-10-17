extends Node2D
class_name CheckpointTarget

@export var associatedBall: Node2D
var isCompleted:bool

signal targetNotify

func ballEntered():
	visible=false
	isCompleted=true
	targetNotify.emit()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if associatedBall == body:
		ballEntered()
