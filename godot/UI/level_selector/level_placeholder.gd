extends Button

var level_scene:PackedScene
var idx

signal level_selected(idx:int)

func init(scene:PackedScene, i:int, level_name:String):
	level_scene = scene
	idx = i
	text = level_name

func _on_pressed() -> void:
	if level_scene:
		level_selected.emit(idx)
