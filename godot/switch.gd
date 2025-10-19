extends Node2D

@onready var button_body := %Button

signal pressed

@export var spring_target_y: float = 0  # The Y position where the button rests unpressed
@export var spring_strength: float = 5000.0
@export var damping: float = 1

func _on_area_2d_body_entered(_body: Node2D) -> void:
	print("PRESSED")
	pressed.emit()
	$Electricity.play()
	$ElectricConnector.set_state(true)

func _physics_process(delta):
	# Spring force: F = -k * x - c * v
	var displacement = %Button.position.y - spring_target_y
	var force = -spring_strength * displacement - damping * %Button.linear_velocity.y
	%Button.apply_central_impulse(Vector2(0, force * delta))

func _on_area_2d_body_exited(body: Node2D) -> void:
	$ElectricConnector.set_state(false)
