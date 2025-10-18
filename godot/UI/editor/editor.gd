extends Control

signal playClicked
signal resetWorldClicked
var selected_element:Node2D
var world_instance

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if selected_element:
			print("Mouse Motion at: ", event.position)
			selected_element.position = event.position
	
	if event is InputEventMouseButton:
		if selected_element:
			selected_element.position = event.position
			self.remove_child(selected_element)
			world_instance.add_child(selected_element)
			selected_element=null



func _on_button_pressed() -> void:
	playClicked.emit()


func _on_item_placeholder_element_selected(element: ItemPlaceholder) -> void:
	print_debug(element.element_name)
	selected_element = element.element_scene.instantiate()
	self.add_child(selected_element)
	pass # Replace with function body.


func _on_reset_button_pressed() -> void:
	resetWorldClicked.emit()
	
