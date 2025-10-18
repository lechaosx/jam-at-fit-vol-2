class_name RopeSegment extends RigidBody2D

func cut():
	get_parent().cut(self)
