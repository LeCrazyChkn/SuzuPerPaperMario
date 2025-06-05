extends Control
@onready var quest_label = $QuestLabel


func _ready():
	QuestManager.quest_advanced.connect(_update_quest_display)
	_update_quest_display()

func _update_quest_display():
	var text := "Active Quests:\n"
	for q in QuestManager.get_active_quests():
		text += "- %s (Stage %d)\n".format([q.name, q.current_stage])
	quest_label.text = text
