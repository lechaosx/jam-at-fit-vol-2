extends Control

signal resumeClicked
signal quitClicked

func _on_resume_button_pressed() -> void:
	resumeClicked.emit()


func _on_quit_pressed() -> void:
	quitClicked.emit()
	get_tree().quit()
