extends Node

var isPaused = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func unPause():
	#Engine.time_scale = 1
	$PauseMenu.hide()
	get_tree().paused = false
	

func pause():
	$PauseMenu.show()
	#Engine.time_scale = 0
	get_tree().paused = true

func process_pause():
	if isPaused:
		unPause()
	else:
		pause()
	isPaused = !isPaused

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		process_pause()
	
	


func _on_pause_menu_resume_clicked() -> void:
	if isPaused:
		process_pause()
