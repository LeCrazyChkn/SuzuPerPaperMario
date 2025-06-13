extends Control
@onready var quest_label = get_node("QuestLabel")


func _ready():
	QuestManager.quest_advanced.connect(Callable(self, "_update_quest_display"))
	_refresh_quests()

func _update_quest_display(name, changes, quest):
	#debug
	#print("Quest updated:", name)
	_refresh_quests()

func _refresh_quests():
	var text = "Active Quests:\n"
	for q in QuestManager.get_active_quests():
		text += "- %s (Stage %d)\n" % [q.name, q.current_stage]
		
		
	quest_label.text = text
	
	if QuestManager.get_active_quests().size() == 0:
		quest_label.text = "No active quests."
