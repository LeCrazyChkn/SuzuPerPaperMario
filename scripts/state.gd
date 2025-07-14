extends Node


var key_status : String = ""
var nene_status: String = ""
var tomo_status: String = ""
var money : int = 1500

func dialogue_quest(quest):
	var delta = QuestManager.advance_quest(quest)
	Game.update_stats(delta)

func dialogue_stat(stat, value):
	Game.update_stats({stat: value})
	
