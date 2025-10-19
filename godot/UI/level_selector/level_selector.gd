extends Control

@export var levels:Array[PackedScene]
@export var level_button: PackedScene

signal level_selected(scene:PackedScene, name:String)

func get_level_name(idx:int):
	return "Level %d" % (idx + 1)
	
func get_level_label(idx:int):
	return "%d" % (idx+1)

func _ready() -> void:
	for i in levels.size():
		var level = levels[i]
		var button = level_button.instantiate()
		button.init(level, i, get_level_label(i))
		button.level_selected.connect(_on_level_selected)
		%LevelsContainer.add_child(button)

func _on_level_selected(idx:int):
	var scene = levels[idx]
	var level_name = get_level_name(idx)
	
	level_selected.emit(scene, level_name)
