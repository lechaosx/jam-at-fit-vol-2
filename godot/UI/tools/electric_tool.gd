extends Control

@export var visibility_mask = 2
var res:PlaceableResource
var world_instance : Node2D
var world_viewport:Viewport

var connector_A:ElecticConnector
var connector_B:ElecticConnector

var store_cull_mask:int

@export var line_scene:PackedScene
var line:Line2D

signal placement_success

func init(resource:PlaceableResource, world:Node2D):
	res = resource
	world_instance = world
	world_viewport = world_instance.get_viewport()
	
	if line_scene:
		line = line_scene.instantiate()
	else:
		line = Line2D.new()
	line.hide()
	add_child(line)
	
	store_cull_mask = world_viewport.canvas_cull_mask
	world_viewport.set_canvas_cull_mask_bit(visibility_mask, true)

func find_first_connector(position:Vector2) -> ElecticConnector:
	var params:PhysicsPointQueryParameters2D = PhysicsPointQueryParameters2D.new()
	params.collide_with_areas = true
	params.collide_with_bodies = true
	#params.collision_mask = 4
	params.position = position
	
	var results:Array[Dictionary] = world_instance.get_world_2d().direct_space_state.intersect_point(params)
	
	for r in results:
		if r.get("collider") is ElecticConnector:
			print_debug("found connector:", r)
			return r.get("collider")
		
	return null

func _exit_tree() -> void:
	world_viewport.canvas_cull_mask=store_cull_mask

func _gui_input(event: InputEvent) -> void:
	print_debug("ashkdvab")
	if event is InputEventMouseMotion:
		if connector_A:
			line.points[1] = event.position
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_RIGHT:
			get_parent().remove_child(self)
			self.queue_free()
			
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT and event.pressed:
			## IMPORTANT ORDER OF THIS CONDITIONS !!
			if connector_A and not connector_B:
				connector_B = find_first_connector(event.position)
			
			if not connector_A:
				connector_A = find_first_connector(event.position)
				if connector_A:
					line.add_point(connector_A.get_global_transform().get_origin())
					line.add_point(event.position)
					line.show()
			
			if connector_A and connector_B:
				connector_A.set_source(connector_B)
				connector_B.set_source(connector_A)
				var cable = res.element_scene.instantiate()
				cable.add_point(connector_A.get_global_transform().origin)
				cable.add_point(connector_B.get_global_transform().origin)
				cable.attach_body_a = connector_A.static_body
				cable.attach_body_b = connector_B.static_body
				world_instance.add_child(cable)
				
				placement_success.emit()
				get_parent().remove_child(self)
				queue_free()
			
			
