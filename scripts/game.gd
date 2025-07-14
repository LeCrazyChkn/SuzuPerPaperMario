# Autoload: Game.gd
extends Node3D

signal stats_changed(phys, soc, ment, emo, ecstasy)
signal stat_values_updated(changes: Dictionary)


var phys := 70.0
var soc := 70.0
var ment := 70.0
var emo := 70.0
var ecstasy := 90.0

var active_quests: Array = []

func update_stats(delta: Dictionary):
	var changes := {}
	
	# Update and track changes
	if delta.has("phys"):
		phys = clamp(phys + delta["phys"], 0, 100)
		changes["phys"] = phys
	if delta.has("soc"):
		soc = clamp(soc + delta["soc"], 0, 100)
		changes["soc"] = soc
	if delta.has("ment"):
		ment = clamp(ment + delta["ment"], 0, 100)
		changes["ment"] = ment
	if delta.has("emo"):
		emo = clamp(emo + delta["emo"], 0, 100)
		changes["emo"] = emo
	if delta.has("ecstasy"):
		ecstasy = clamp(ecstasy + delta["ecstasy"], 0, 100)
		changes["ecstasy"] = ecstasy

	emit_signal("stat_values_updated", changes)
	
	print(changes)
