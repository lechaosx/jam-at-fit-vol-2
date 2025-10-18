extends Node2D

var _parent: Node2D

func _ready() -> void:
	_parent = get_parent()

func _process(_delta: float) -> void:
	rotation = -_parent.transform.get_rotation()
