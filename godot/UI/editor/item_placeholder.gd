extends Control
class_name ItemPlaceholder

@export var element_scene: PackedScene
@export var element_name: String
@export var texture: Texture2D


signal element_selected(element:ItemPlaceholder)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MainSprite.texture = texture
	pass # Replace with function body.

func _on_pressed() -> void:
	element_selected.emit(self)
	pass # Replace with function body.
