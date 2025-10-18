extends Control

signal resumeClicked
signal quitClicked
signal resetToEditor

var isInEditor:bool:
	set(val): 
		$VBoxContainer/RestartButton.visible = !val
		isInEditor = val

func _on_resume_button_pressed() -> void:
	resumeClicked.emit()

func _on_quit_pressed() -> void:
	quitClicked.emit()
	get_tree().quit()


func _on_restart_button_pressed() -> void:
	resetToEditor.emit()
	resumeClicked.emit()
