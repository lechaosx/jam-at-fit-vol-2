extends Node2D

@export var is_on: bool = false
@onready var spriteOn = $"Sprite2D-on"
@onready var spriteOff = $"Sprite2D-off"
var is_on_prev: bool = is_on

func _ready() -> void:
	on_off_changed(is_on)

func _process(_delta: float) -> void:
	if is_on != is_on_prev:
		is_on_prev = is_on
		on_off_changed(is_on)

func on_off_changed(current: bool) -> void:
	print_debug("electric/switch: %s" % ["ON" if current else "off"])
	if current:
		spriteOn.visible = true
		spriteOff.visible = false
	else:
		spriteOn.visible = false
		spriteOff.visible = true
