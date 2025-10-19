extends Control

@export var levels:Array[PackedScene]
@export var level_button_scene: PackedScene

var selected_idx
var unlocked_levels:int = 0:
	set(val):
		unlocked_levels = val
		$VBoxContainer/HBoxContainer/Label.text = "Progress code: %s" % get_code()
		update_unlocked()

signal level_selected(scene:PackedScene, name:String)

func update_unlocked():
	for i in %LevelsContainer.get_child_count():
		var level_button = %LevelsContainer.get_child(i)
		level_button.disabled = ! (i <= unlocked_levels)

func get_level_name(idx:int):
	return "Level %d" % (idx + 1)
	
func get_level_label(idx:int):
	return "%d" % (idx+1)

func _ready() -> void:
	for i in levels.size():
		var level = levels[i]
		var button = level_button_scene.instantiate()
		button.init(level, i, get_level_label(i))
		button.level_selected.connect(_on_level_selected)
		%LevelsContainer.add_child(button)
	update_unlocked()
	print_debug(Marshalls.utf8_to_base64("%d" % (5*57+69)))

func _on_level_selected(idx:int):
	var scene = levels[idx]
	var level_name = get_level_name(idx)
	selected_idx = idx
	level_selected.emit(scene, level_name)
	
func completed():
	if unlocked_levels <= selected_idx+1:
		unlocked_levels = selected_idx+1

func get_code()->String:
	#return Marshalls.variant_to_base64()
	return Marshalls.utf8_to_base64("%d" % (unlocked_levels*57+69))

func decode_code(s:String)->int:
	#return (Marshalls.base64_to_variant(s) - 69) / 57
	return (int(Marshalls.base64_to_utf8(s)) - 69 ) / 57

func _on_enter_code_pressed() -> void:
	var code_levels =(decode_code($VBoxContainer/HBoxContainer/CodeEdit.text))
	if unlocked_levels < code_levels:
		unlocked_levels = code_levels
	
