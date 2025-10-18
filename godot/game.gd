extends Node

var isPaused = false
var isInEditor:bool = true:
	set(amount):
		$PauseMenu.isInEditor = amount
		$Editor.visible = amount
		isInEditor = amount

@export var world_scene:PackedScene
var editor_world_instance
var play_world_instance

func reset_world():
	print_debug("world reset")
	
	if editor_world_instance:
		remove_world(editor_world_instance)

	editor_world_instance = world_scene.instantiate()
	editor_world_instance.process_mode = Node.PROCESS_MODE_DISABLED
	$SubViewportContainer/SubViewport.add_child(editor_world_instance)
	$Editor.world_instance=editor_world_instance

func remove_world(world_node):
		$SubViewportContainer/SubViewport.remove_child(world_node)
		world_node.queue_free()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_world()
	
func unPause():
	$PauseMenu.hide()
	get_tree().paused = false

func pause():
	$PauseMenu.show()
	get_tree().paused = true 

func process_pause():
	if isPaused:
		unPause()
	else:
		pause()
	isPaused = !isPaused

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		process_pause()

func _on_pause_menu_resume_clicked() -> void:
	if isPaused:
		process_pause()

func _on_editor_play_clicked() -> void:
	isInEditor = false
	play_world_instance = editor_world_instance.duplicate()
	play_world_instance.process_mode = Node.PROCESS_MODE_PAUSABLE
	$SubViewportContainer/SubViewport.add_child(play_world_instance)
	editor_world_instance.hide()

func _on_editor_reset_world_clicked() -> void:
	reset_world()

func _on_pause_menu_reset_to_editor() -> void:
	editor_world_instance.show()
	if play_world_instance:
		play_world_instance.hide()
		remove_world(play_world_instance)
	isInEditor=true
