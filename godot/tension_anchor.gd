extends PinJoint2D

signal trigger

var _pulling := false
var _start_distance: int

func _ready() -> void:
	_start_distance = global_position.distance_to(get_node(node_b).global_position) 

func _process(_delta: float) -> void:
	if not _pulling and global_position.distance_to(get_node(node_b).global_position) >= _start_distance + 0.5:
		if not _pulling:
			print("PULLED")
			_pulling = true
			trigger.emit()
	else:
		if _pulling:
			print("RELEASED")
			_pulling = false
