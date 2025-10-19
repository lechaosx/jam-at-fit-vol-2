extends Control

signal playClicked(Node2D)

var placeable_button_scene:PackedScene = preload("res://UI/editor/item_placeholder.tscn")
var basic_tool_scene:PackedScene = preload("res://UI/tools/basic_tool.tscn")

@onready var viewport = $SubViewportContainer/SubViewport

var world_scene:PackedScene
var level_name:String:
	set(val):
		level_name = val
		$LevelName.text = val

var selected_button: ItemPlaceholder
var world_instance:Node2D
var targets_manager:TargetsManager
var level_placeables: LevelPlaceables

var magic_number = 0

func _on_button_pressed() -> void:
	playClicked.emit(get_world_duplicate())

func remove_all_tools():
	for t in %ToolsContainer.get_children():
		%ToolsContainer.remove_child(t)
		t.queue_free()
	

func _on_item_placeholder_element_selected(resource: PlaceableResource, button:ItemPlaceholder) -> void:
	remove_all_tools()
	selected_button = button
	
	var tool_scene = resource.tool
	if not tool_scene:
		tool_scene = basic_tool_scene
	
	var tool = tool_scene.instantiate()
	tool.init(resource, world_instance, magic_number)
	tool.placement_success.connect(placement_success)
	%ToolsContainer.add_child(tool)

func placement_success():
	selected_button.item_placed()
	magic_number += 1

func _on_reset_button_pressed() -> void:
	spawn_world(world_scene)
	remove_all_tools()
	
func remove_world_instance(world:Node2D):
	if not world:
		return
		
	world.hide()
	$SubViewportContainer/SubViewport.remove_child(world)
	world.queue_free()
	
func load_placeables_from_level():
	for child in %PlaceablesContainer.get_children():
		%PlaceablesContainer.remove_child(child)
		child.queue_free()

	for placeable in level_placeables.placeables:
		var placeable_button_instance = placeable_button_scene.instantiate()
		placeable_button_instance.set_resource(placeable.placeable_res, placeable.max_count)
		%PlaceablesContainer.add_child(placeable_button_instance)
		placeable_button_instance.element_selected.connect(_on_item_placeholder_element_selected)
		
		
func spawn_world(scene:PackedScene):
	magic_number = 0
	remove_world_instance(world_instance)
	world_instance = scene.instantiate()
	world_instance.process_mode = Node.PROCESS_MODE_DISABLED
	$SubViewportContainer/SubViewport.add_child(world_instance)
	
	for child in world_instance.get_children():
		if child is LevelPlaceables:
			level_placeables = child
		if child is TargetsManager:
			targets_manager = child
	
	load_placeables_from_level()
	
	
func get_world_duplicate()->Node2D:
	if world_instance:
		return world_instance.duplicate()
	return null
	
func set_world(world:PackedScene):
	world_scene=world
	spawn_world(world)
	
