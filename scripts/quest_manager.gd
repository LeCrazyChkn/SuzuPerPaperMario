# Autoload this as: QuestManager
extends Node

var quests: Dictionary = {}

@onready var banner = get_node("/root/Game/UI/QuestBanner")


signal quest_advanced(name: String, stage: int, completed: bool)

func _ready():
	_init_quests()
	#Not working: QuestBanner
	#await get_tree().process_frame  # Wait one frame
	#var banner = get_node("/root/Game/UI/QuestBanner")
	#banner.show_quest_completed_banner("Test Quest")

func _init_quests():
	var quest1 := Quest.new()
	quest1.name = "Make some Friends"
	quest1.description = "Fix the broken tower."
	quest1.stages = [
		{ "soc": 20, "phys": 30 },
		{ "ment": 10 }
	]
	add_quest(quest1)


	var quest2 := Quest.new()
	quest2.name = "Find the Key"
	quest2.description = "Find the missing key near the boxes."
	quest2.stages = [
		{ "phys": 10 },
		{ "emo": 10, "soc": 20 }
	]
	add_quest(quest2)



func add_quest(quest: Quest):
	quests[quest.name] = quest

func advance_quest(name: String) -> Dictionary:
	if not quests.has(name):
		#debug
		#print("Quest not found: ", name)
		return {}
	var quest = quests[name]
	var result = quest.advance_stage()
	emit_signal("quest_advanced", quest.name, quest.current_stage, quest.completed)
	return result

func get_active_quests() -> Array:
	var list := []
	for q in quests.values():
		if q.current_stage == len(q.stages):
			#Not working: QuestBanner
			#QuestManager.quest_banner.show_quest_completed_banner(("Quest Complete!"))
			print("completed_sugoi " + str(q.name))
		elif not q.completed:
			list.append(q)
	return list
