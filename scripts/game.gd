# Autoload: Game.gd
extends Node3D

signal stats_changed(phys, soc, ment, emo, ecstasy)

var phys := 100.0
var soc := 100.0
var ment := 100.0
var emo := 100.0
var ecstasy := 100.0

var active_quests: Array = []

func update_stats(delta: Dictionary):
	phys = clamp(phys + delta.get("phys", 0), 0, 100)
	soc = clamp(soc + delta.get("soc", 0), 0, 100)
	ment = clamp(ment + delta.get("ment", 0), 0, 100)
	emo = clamp(emo + delta.get("emo", 0), 0, 100)
	ecstasy = clamp(ecstasy + delta.get("ecstasy", 0), 0, 100)
	
	emit_signal("stats_changed", phys, soc, ment, emo, ecstasy)
