extends Node3D

@export var follow_speed : float = 10.0
@export var rotation_lerp_speed := 5.0

func _process(delta):
	if get_parent() == null:
		return

	var target_position = get_parent().global_transform.origin

	# Lerp this SpringArm's position toward the player's position
	global_transform.origin = global_transform.origin.lerp(target_position, follow_speed * delta)
