extends Node
class_name World

signal completed

var isCompleted = false

var allTargets:int
var completedTargets:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	registerTargets()

func updateTargetCounts():
	completedTargets = get_completed_targets()
	
	print_debug("Completed:", completedTargets, "/", allTargets)
	
	if completedTargets>=allTargets:
		completed.emit()
		isCompleted = true
		print_debug("finished")
		
func addTarget(node:Node2D):
	$Targets.add_child(node)

func get_completed_targets() -> int:
	var count = 0
	for node in $Targets.get_children():
		if node is FinalTarget and node.isBallPresent:
			count += 1
		if node is CheckpointTarget and node.isCompleted:
			count += 1
	return count

func registerTargets():
	allTargets = 0
	for target in $Targets.get_children():
		if target is FinalTarget:
			allTargets += 1
			target.targetNotify.connect(updateTargetCounts)
		if target is CheckpointTarget:
			allTargets += 1
			target.targetNotify.connect(updateTargetCounts)


func _on_cut_rope_button_pressed() -> void:
	$Rope.cut_rope_at(10)
