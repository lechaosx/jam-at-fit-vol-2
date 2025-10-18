extends Button
class_name ItemPlaceholder

#@export var element_scene: PackedScene
#@export var element_name: String
#@export var texture: Texture2D

@export var res: PlaceableResource
var max_count = 0
var placed_count = 0

signal element_selected(element:PlaceableResource, ItemPlaceholder)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if res:
		$HBoxContainer/MainSprite.texture = res.texture

func _on_pressed() -> void:
	element_selected.emit(res, self)
	pass # Replace with function body.

func set_resource(val:PlaceableResource, max_cnt:int):
	res = val
	max_count = max_cnt
	placed_count = 0
	$HBoxContainer/MainSprite.texture = res.texture
	update_counts()

func update_counts():
	$HBoxContainer/Label.text = "%d/%d" % [placed_count, max_count]
	
	if placed_count >= max_count:
		hide()

func item_placed():
	placed_count += 1
	update_counts()
