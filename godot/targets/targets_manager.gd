extends Node
class_name TargetsManager

signal completed

var isCompleted = false

var completedTargets:int
var targets_array: Array

func registerTargets():
	targets_array.clear()
	for target in get_parent().get_children():
		if target is FinalTarget:
			targets_array.append(target)
		if target is CheckpointTarget:
			targets_array.append(target)
			
	for target in targets_array:
		target.targetNotify.connect(update_targets)
	
func _ready() -> void:
	registerTargets()

func update_targets():	
	completedTargets = get_completed_targets()
	if completedTargets >= targets_array.size():
		completed.emit()
		isCompleted = true
		
	print_debug("targets:", completedTargets, targets_array.size())

func get_completed_targets() -> int:
	var count = 0
	for target in targets_array:
		if target is FinalTarget and target.isBallPresent:
			count += 1
		if target is CheckpointTarget and target.isCompleted:
			count += 1
	return count
