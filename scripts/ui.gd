extends Control

@onready var phys_bar = $Phys/PhysBottom/PhysBar
@onready var soc_bar = $Soc/SocBottom/SocBar
@onready var ment_bar = $Ment/MentBottom/MentBar
@onready var emo_bar = $Emo/EmoBottom/EmoBar
@onready var ecstasy_bar = $Ecstasy/EcstasyBottom/EcstasyBar

func _ready():
	Game.stats_changed.connect(_on_stats_changed)
	

func _on_stats_changed(phys, soc, ment, emo, ecstasy):
	phys_bar.set_health(phys)
	soc_bar.set_health(soc)
	ment_bar.set_health(ment)
	emo_bar.set_health(emo)
	ecstasy_bar.set_health(ecstasy)
