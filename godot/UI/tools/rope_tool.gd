extends Control

@export var visibility_mask = 3
var res:PlaceableResource
var world_instance : Node2D
var world_viewport:Viewport
var idx = 0

var connector_A:RopeConnector
var connector_B:RopeConnector

var store_cull_mask:int

@export var line_scene:PackedScene
var line:Line2D

signal placement_success

func init(resource:PlaceableResource, world:Node2D, i:int):
	res = resource
	world_instance = world
	world_viewport = world_instance.get_viewport()
	idx=i
	
	if line_scene:
		line = line_scene.instantiate()
	else:
		line = Line2D.new()
	line.hide()
	add_child(line)
	
	store_cull_mask = world_viewport.canvas_cull_mask
	world_viewport.set_canvas_cull_mask_bit(visibility_mask, true)

func find_first_connector(_position:Vector2) -> RopeConnector:
	var params:PhysicsPointQueryParameters2D = PhysicsPointQueryParameters2D.new()
	params.collide_with_areas = true
	params.collide_with_bodies = true
	#params.collision_mask = 4
	params.position = _position
	
	var results:Array[Dictionary] = world_instance.get_world_2d().direct_space_state.intersect_point(params)
	
	for r in results:
		if r.get("collider") is RopeConnector:
			print_debug("found connector:", r)
			return r.get("collider")
		
	return null

func _exit_tree() -> void:
	world_viewport.canvas_cull_mask=store_cull_mask

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if connector_A:
			#var cnt = line.points.size()
			line.points[-1] = event.position
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_RIGHT:
			get_parent().remove_child(self)
			self.queue_free()
			
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT and event.pressed:
			## IMPORTANT ORDER OF THIS CONDITIONS !!
			if connector_A and not connector_B:
				connector_B = find_first_connector(event.position)
				if not connector_B:
					line.add_point(event.position)
			
			if not connector_A:
				connector_A = find_first_connector(event.position)
				if connector_A:
					line.add_point(connector_A.get_global_transform().get_origin())
					line.add_point(event.position)
					line.show()
			
			if connector_A and connector_B:
				var rope = res.element_scene.instantiate()
				rope.name+="%d" % idx
				line.points[-1] = connector_B.get_global_transform().origin
				rope.attach_body_a = connector_A.static_body
				rope.attach_body_b = connector_B.static_body
				
				print_debug(connector_A.static_body, connector_B.static_body)
				
				for point in line.points:
					rope.add_point(point)
				world_instance.add_child(rope)
				
				placement_success.emit()
				get_parent().remove_child(self)
				queue_free()
			
			
