extends Control

var res:PlaceableResource
var world_instance : Node2D
var target_instance : Node2D

signal placement_success

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		target_instance.show()
		target_instance.position = event.position
		print_debug(get_global_mouse_position())
		
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_RIGHT:
			get_parent().remove_child(self)
			self.queue_free()

		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
			remove_child(target_instance)
			world_instance.add_child(target_instance)
			target_instance.process_mode = Node.PROCESS_MODE_INHERIT
			placement_success.emit()
			queue_free()

		if event.button_index == MouseButton.MOUSE_BUTTON_WHEEL_DOWN:
			target_instance.rotate(PI/16)
		
		if event.button_index == MouseButton.MOUSE_BUTTON_WHEEL_UP:
			target_instance.rotate(-PI/16)

		if event.button_index == MouseButton.MOUSE_BUTTON_MIDDLE and event.pressed:
			target_instance.scale.x = target_instance.scale.x * -1

func init(resource:PlaceableResource, world:Node2D):
	res = resource
	world_instance = world
	
	target_instance = res.element_scene.instantiate()
	add_child(target_instance)
	target_instance.position = world.get_viewport().get_mouse_position()
	target_instance.process_mode = Node.PROCESS_MODE_DISABLED
