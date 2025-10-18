extends Line2D

@export var attach_body_a: RigidBody2D
@export var attach_body_b: RigidBody2D

signal rope_tense_a
signal rope_tense_b

var segments: Array[RigidBody2D] = []
var joints: Array[PinJoint2D] = []
var anchor_a: Node = null
var anchor_b: Node = null

static func catmull_rom_spline(points: PackedVector2Array, resolution: int = 10) -> PackedVector2Array:
	if points.size() < 2:
		return points
	
	points.insert(0, points[0] - (points[1] - points[0]))
	points.append(points[-1] + (points[-1] - points[-2]))

	var smooth_points := PackedVector2Array()

	for i in range(1, points.size() - 2):
		var p0 = points[i - 1]
		var p1 = points[i]
		var p2 = points[i + 1]
		var p3 = points[i + 2]

		for t in range(0, resolution):
			var tt = t / float(resolution)
			var tt2 = tt * tt
			var tt3 = tt2 * tt

			var q = (0.5* ((2.0 * p1) + (-p0 + p2) * tt + (2.0 * p0 - 5.0 * p1 + 4 * p2 - p3) * tt2 + (-p0 + 3.0 * p1 - 3.0 * p2 + p3) * tt3))
			smooth_points.append(q)

	return smooth_points

func _ready():
	if points.size() < 2:
		push_error("Rope needs at least two points.")
		return
		
	var segment_distance := 24.0
		
	for i in range(points.size() - 1):
		var segment_begin := points[i]
		var segment_end := points[i + 1]
		
		var distance := segment_begin.distance_to(segment_end)
		
		
		for j in range(distance / segment_distance):
			var segment = preload("res://rope_segment.tscn").instantiate()
			segment.global_position = segment_begin.lerp(segment_end, (j + 0.5) * segment_distance / distance)
			segment.global_rotation = (segment_end - segment_begin).angle() + PI / 2
			segments.append(segment)
			add_child(segment)
		
	for i in range(segments.size() - 1):
		var joint = PinJoint2D.new()
		joint.node_a = segments[i].get_path()
		joint.node_b = segments[i + 1].get_path()
		joint.position.y = - segment_distance / 2
		segments[i].add_child(joint)
		joints.append(joint)
		
	var tension_anchor := preload("res://tension_anchor.tscn")
		
	anchor_a = tension_anchor.instantiate()
	anchor_a.body_a = segments.front()
	anchor_a.body_b = attach_body_a
	anchor_a.global_position = segments.front().global_position
	anchor_a.trigger.connect(func(): rope_tense_a.emit())
	add_child(anchor_a)
	
	anchor_b = tension_anchor.instantiate()
	anchor_b.body_a = segments.back()
	anchor_b.body_b = attach_body_b
	anchor_b.global_position = segments.back().global_position
	anchor_b.trigger.connect(func(): rope_tense_b.emit())
	add_child(anchor_b)
	
func _process(_delta: float) -> void:
	points = catmull_rom_spline(segments.map(func(x): return x.position))
	
