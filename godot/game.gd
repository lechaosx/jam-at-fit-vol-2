extends Node

var isPaused = false
var isInEditor:bool = true:
	set(amount):
		$Editor.visible = amount
		isInEditor = amount

@export var world_scene:PackedScene
var editor_world_instance
var play_world_instance

func remove_world(world_node):
		$SubViewportContainer/SubViewport.remove_child(world_node)
		world_node.queue_free()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Editor.set_world(world_scene)

func unPause():
	$PauseMenu.hide()
	get_tree().paused = false
	isPaused = false

func pause():
	$PauseMenu.show()
	get_tree().paused = true 
	isPaused=true

func process_pause():
	if !isInEditor:
		reset_to_editor()
		return
	
	if isPaused:
		unPause()
	else:
		pause()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		process_pause()

func _on_pause_menu_resume_clicked() -> void:
	unPause()

func _on_editor_play_clicked(world:Node2D) -> void:
	isInEditor = false
	play_world_instance = world
	play_world_instance.process_mode = Node.PROCESS_MODE_PAUSABLE
	$SubViewportContainer/SubViewport.add_child(play_world_instance)

func reset_to_editor() -> void:
	if play_world_instance:
		play_world_instance.hide()
		remove_world(play_world_instance)
	isInEditor=true


func _on_level_selector_level_selected(scene: PackedScene, level_name: String) -> void:
		$Editor.set_world(scene)
		$Editor.level_name = level_name
		$LevelSelector.hide()
		$Editor.show()


func _on_pause_menu_go_to_level_selector() -> void:
	$Editor.hide()
	$LevelSelector.show()
	unPause()
