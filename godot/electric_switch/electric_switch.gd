class_name ElectricSwitch
extends Node2D

@export var is_on: bool = false
@onready var spriteOn = $"Sprite2D-on"
@onready var spriteOff = $"Sprite2D-off"
@onready var connector = $ElectricConnector

func _ready() -> void:
	set_state(is_on)

func on_off_changed(current: bool) -> void:
	print_debug("electric/switch: %s - GFX" % connector.on_off_str(is_on))
	if current:
		spriteOn.visible = true
		spriteOff.visible = false
	else:
		spriteOn.visible = false
		spriteOff.visible = true

func _on_area_2d_body_entered(_body: Node2D) -> void:
	print_debug("electric/switch: collission ... %s >> %s" % [
		connector.on_off_str(is_on),
		connector.on_off_str(!is_on)
	])
	set_state(!is_on)

func set_state(value: bool) -> void:
	is_on = value
	on_off_changed(value)
	print_debug("set state switch %s" % ("true" if value else "false"))
	$ElectricConnector.set_state(value)
