# Quest.gd
class_name Quest
extends Resource

var name: String
var description: String
var current_stage := 0
var completed := false
var stages: Array = []  # Each stage is a Dictionary of stat changes

func advance_stage() -> Dictionary:
	if current_stage < stages.size():
		var changes = stages[current_stage]
		current_stage += 1
		if current_stage >= stages.size():
			completed = true
		return changes
	return {}
