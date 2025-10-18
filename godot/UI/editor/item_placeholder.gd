extends Button
class_name ItemPlaceholder

#@export var element_scene: PackedScene
#@export var element_name: String
#@export var texture: Texture2D

@export var res: PlaceableResource

signal element_selected(element:PlaceableResource, position:Vector2)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if res:
		$MainSprite.texture = res.texture

func _on_pressed() -> void:
	element_selected.emit(res)
	pass # Replace with function body.

func set_resource(val:PlaceableResource):
	res = val
	$MainSprite.texture = res.texture
