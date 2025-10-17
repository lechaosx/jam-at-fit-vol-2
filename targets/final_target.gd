extends Node2D
class_name FinalTarget

@export var associatedBall: Node2D
var isBallPresent:bool

signal targetNotify

func ballEntered():
	isBallPresent=true
	targetNotify.emit()

func ballExited():
	isBallPresent=false
	targetNotify.emit()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if associatedBall == body:
		ballEntered()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if associatedBall == body:
		ballExited()
