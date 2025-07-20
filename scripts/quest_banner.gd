extends RichTextLabel #with ChatGPT


func _ready() -> void:
	self.show()
	show_quest_completed_banner("Test")



func show_quest_completed_banner(quest_name: String):
	self.show()
	
	self.text = "Quest Completed: " + quest_name

	var tween = create_tween()
	self.modulate = Color(1, 1, 1, 0)
	tween.tween_property(self, "modulate", Color(1, 1, 1, 1), 0.5)
	tween.tween_interval(2.0)
	tween.tween_property(self, "modulate", Color(1, 1, 1, 0), 0.5)
	tween.tween_callback(Callable(self, "hide"))
