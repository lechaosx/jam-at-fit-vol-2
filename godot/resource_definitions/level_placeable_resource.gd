extends Resource
class_name LevelPlaceableResource

@export var placeable_res:PlaceableResource
@export var max_count:int
var current_count = 0

func _init():
	resource_local_to_scene = true
