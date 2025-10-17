extends Control

signal resumeClicked
signal quitClicked

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_resume_button_pressed() -> void:
	resumeClicked.emit()


func _on_quit_pressed() -> void:
	quitClicked.emit()
	get_tree().quit()
