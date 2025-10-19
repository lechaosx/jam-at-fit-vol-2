extends Node2D

@onready var p:LevelPlaceables = $LevelPlaceables

func _ready() -> void:
	for i in p.placeables:
		i.max_count=999
