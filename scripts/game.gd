extends Node3D

@onready var ui = $UI

@onready var phys_bar = ui.get_node("Phys/PhysBottom/PhysBar")
@onready var soc_bar = ui.get_node("Soc/SocBottom/SocBar")
@onready var ment_bar = ui.get_node("Ment/MentBottom/MentBar")
@onready var emo_bar = ui.get_node("Emo/EmoBottom/EmoBar")
@onready var ecstasy_bar = ui.get_node("Ecstasy/EcstasyBottom/EcstasyBar")

@onready var player = $PaperCharacter

func _ready():
	player.stats_changed.connect(_on_stats_changed)

func _on_stats_changed(phys, soc, ment, emo, ecstasy):
	phys_bar.set_health(phys)
	soc_bar.set_health(soc)
	ment_bar.set_health(ment)
	emo_bar.set_health(emo)
	ecstasy_bar.set_health(ecstasy)
