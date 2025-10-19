extends Control

signal resumeClicked
signal quitClicked
signal go_to_level_selector

func _on_resume_button_pressed() -> void:
	resumeClicked.emit()

func _on_quit_pressed() -> void:
	quitClicked.emit()
	get_tree().quit()


func _on_level_selector_pressed() -> void:
	go_to_level_selector.emit()
