class_name ElecticConnector
extends Node2D

signal on_off_changed(value: bool)

var source

func set_source(source: ElecticConnector) -> void:
	if source == null:
		print_debug("electricity/connector: disconnect(%s + %s)" % [
			source.get_parent().name,
			self.get_parent().name
		])
		self.source = null
	else:
		print_debug("electricity/connector: connect(%s + %s)" % [
			source.get_parent().name,
			self.get_parent().name
		])
		source.on_off_changed.connect(get_parent()._on_on_off_changed)

func has_source() -> bool:
	return true if source != null else false

func on_off_str(value: bool) -> String:
	return "ON" if value else "off"
