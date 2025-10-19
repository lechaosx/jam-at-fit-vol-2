class_name ElecticConnector
extends Node2D

signal on_off_changed(value: bool)
signal propagate_state_cahnged(value:bool)
# Will be called twice per cable connection
signal on_connected()

var source
@onready var static_body:StaticBody2D = $StaticBody2D

func state_changed(value:bool):
	propagate_state_cahnged.emit(value)

func set_state(value:bool):
	on_off_changed.emit(value)
	propagate_state_cahnged.emit(value)

func set_source(_source: ElecticConnector) -> void:
	if _source == null:
		print_debug("electricity/connector: disconnect(%s + %s)" % [
			_source.get_parent().name,
			self.get_parent().name
		])
		self.source = null
	else:
		print_debug("electricity/connector: connect(%s + %s)" % [
			_source.get_parent().name,
			self.get_parent().name
		])
		_source.on_off_changed.connect(state_changed)
		_source.on_connected.emit()
		on_connected.emit()

func has_source() -> bool:
	return true if source != null else false

func on_off_str(value: bool) -> String:
	return "ON" if value else "off"
