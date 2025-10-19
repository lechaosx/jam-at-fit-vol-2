class_name ElecticConnector
extends Node2D

#signal on_off_changed(value: bool)
signal propagate_state_cahnged(value:bool)
# Will be called twice per cable connection
signal on_connected()

@export var connectors:Array[ElecticConnector]

var source
@onready var static_body:StaticBody2D = $StaticBody2D

func state_changed(value:bool):
	propagate_state_cahnged.emit(value)
	print_debug("connector changed %s" % ("true" if value else "false"))

func set_state(value:bool):
	print_debug("connector set state %s" % ("true" if value else "false"))
	#on_off_changed.emit(value)
	propagate_state_cahnged.emit(value)
	for c in connectors:
		c.propagate_state_cahnged.emit(value)

func _create_connection(con:ElecticConnector):
	if connectors.has(con):
		return
	connectors.append(con)
	con.connect_with(self)

func connect_with(connector:ElecticConnector):
	_create_connection(connector)
#
	for c in connector.connectors:
		_create_connection(c)
#
#func set_source(_source: ElecticConnector) -> void:
	#if _source == null:
		#print_debug("electricity/connector: disconnect(%s + %s)" % [
			#_source.get_parent().name,
			#self.get_parent().name
		#])
		#self.source = null
	#else:
		#print_debug("electricity/connector: connect(%s + %s)" % [
			#_source.get_parent().name,
			#self.get_parent().name
		#])
		#_source.on_off_changed.connect(state_changed)
		#_source.on_connected.emit()
		#on_connected.emit()
#
#func has_source() -> bool:
	#return true if source != null else false
#
func on_off_str(value: bool) -> String:
	return "ON" if value else "off"
