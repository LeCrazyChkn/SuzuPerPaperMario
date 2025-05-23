extends Node3D

@onready var player = $PaperCharacter
@onready var ui = $UI

func _ready():
	player.phys_changed.connect(ui.get_node("Phys/PhysBottom/PhysBar").set_health)
	player.soc_changed.connect(ui.get_node("Soc/SocBottom/SocBar").set_health)
	player.ment_changed.connect(ui.get_node("Ment/MentBottom/MentBar").set_health)
	player.emo_changed.connect(ui.get_node("Emo/EmoBottom/EmoBar").set_health)
	player.ecstasy_changed.connect(ui.get_node("Ecstasy/EcstasyBottom/EcstasyBar").set_health)
