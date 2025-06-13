# Quest.gd
class_name Quest
extends RefCounted

var name: String = ""
var description: String = ""
var current_stage: int = 0
var stages: Array[Dictionary] = []
var completed: bool = false

func advance_stage() -> Dictionary:
	#debug
	#print("Advancing quest stage:", name, "from", current_stage)
	if current_stage < stages.size():
		var changes = stages[current_stage]
		current_stage += 1
		if current_stage >= stages.size():
			completed = true
		return changes
	return {}
