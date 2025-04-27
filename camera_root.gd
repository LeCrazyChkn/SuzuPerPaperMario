extends Node3D

@export var follow_speed : float = 5.0
@export var rotation_speed : float = 5.0
@export var player_path : NodePath

var player : Node3D
var target_rotation_y : float = 0.0

func _ready():
	player = get_node(player_path)
	target_rotation_y = rotation.y

func _process(delta):
	# --- Smoothly rotate toward target_rotation_y ---
	var current_rot = rotation
	current_rot.y = lerp_angle(current_rot.y, target_rotation_y, rotation_speed * delta)
	rotation = current_rot

	# --- Check for input to rotate ---
	if Input.is_action_just_pressed("camera_rotate_left"):
		target_rotation_y += deg_to_rad(90)
	elif Input.is_action_just_pressed("camera_rotate_right"):
		target_rotation_y -= deg_to_rad(90)

	#debugging: see CameraRoot direction
	print(target_rotation_y)
