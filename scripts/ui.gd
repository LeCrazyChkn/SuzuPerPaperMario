extends Control

@onready var phys_bar = $Phys/PhysBottom/PhysBar
@onready var soc_bar = $Soc/SocBottom/SocBar
@onready var ment_bar = $Ment/MentBottom/MentBar
@onready var emo_bar = $Emo/EmoBottom/EmoBar
@onready var ecstasy_bar = $Ecstasy/EcstasyBottom/EcstasyBar
@onready var banner = $QuestBanner

func _ready():
	Game.stat_values_updated.connect(_on_stat_values_updated)


func _on_stat_values_updated(changes: Dictionary):
	if changes.has("phys"):
		phys_bar.set_health(changes["phys"])
	if changes.has("soc"):
		soc_bar.set_health(changes["soc"])
	if changes.has("ment"):
		ment_bar.set_health(changes["ment"])
	if changes.has("emo"):
		emo_bar.set_health(changes["emo"])
	if changes.has("ecstasy"):
		ecstasy_bar.set_health(changes["ecstasy"])
		
