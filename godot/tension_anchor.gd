extends RigidBody2D

signal trigger

@export var body_a: PhysicsBody2D = null
@export var body_b: PhysicsBody2D = null

func _ready() -> void:
	if body_b:
		%Spring.node_b = body_b.get_path()
		
	if body_a:
		%Joint.node_b = body_a.get_path()

func _process(_delta: float) -> void:
	if body_a and body_b:
		if body_a.global_position.distance_to(body_b.global_position) > 50:
			trigger.emit()
