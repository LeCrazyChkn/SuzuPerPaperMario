extends CharacterBody3D

#Animation Variables (Paper Mario Tutorial)
@onready var sprite := $Sprite
var flip_speed:float = 20.0
var face_right: bool = true #horizontal rotation
var face_up: bool = false #Vertical 

#Movement Variables (ChatGPT)
@export var speed : float = 5.0
@export var acceleration : float = 14.0
@export var deceleration : float = 20.0
var target_velocity : Vector3 = Vector3.ZERO

#Cmaera Rotate Variables (ChatGPT)
@export var follow_speed : float = 5.0
@export var rotation_speed : float = 5.0
@export var player_path : NodePath

var player : Node3D
var target_rotation_y : float = 0.0

	

func _ready() -> void:
	sprite.play("down_idle")
	player = get_node(player_path)
	target_rotation_y = rotation.y
	

func _physics_process(delta):
	#4 direction input (for Paper Mario Tutorial)
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	
	#Handling movement section (written by ChatGPT)
	var movement_vector = Vector2.ZERO

	# Get keyboard input
	movement_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	movement_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	# Normalize to prevent faster diagonal movement
	#movement_vector = movement_vector.normalized()
	
		# LIMIT the length instead of normalizing
	if movement_vector.length() > 1.0:
		movement_vector = movement_vector.normalized()
		
	

	# Target velocity based on input
	target_velocity.x = movement_vector.x * speed
	target_velocity.z = movement_vector.y * speed

	# Accelerate towards target velocity
	velocity.x = move_toward(velocity.x, target_velocity.x, acceleration * delta)
	velocity.z = move_toward(velocity.z, target_velocity.z, acceleration * delta)

	# Apply deceleration if no input
	if movement_vector == Vector2.ZERO:
		velocity.x = move_toward(velocity.x, 0, deceleration * delta)
		velocity.z = move_toward(velocity.z, 0, deceleration * delta)

	# Move the character
	move_and_slide()
	
	



	#handling animations (Paper Mario Tutorial)
	var new_animation : String = "idle"
	var new_suffix : String = "down_"
	
	if input_dir.x > 0.0: #checks if facing right
		face_right = true
	elif input_dir.x < 0.0:
		face_right = false
		
	if abs(input_dir.x) > abs(input_dir.y): # only shows up animation if walking upwards
		face_up = false
	else: 
		if input_dir.y < 0.0: # shows up animation after up is pressed
			face_up = true
		elif input_dir.y > 0.0:
			face_up = false
		
	
	
	if input_dir != Vector2.ZERO: #starts run animations if moving
		new_animation = "walk"
	else:
		new_animation = "idle"
			
			
	if face_up: # plays 'up' animations if facing up
		new_suffix = "up_" 
	else:
		new_suffix = "down_"
		
	
	
	if face_right: #rotates sprite to face right
		sprite.rotation_degrees.y = move_toward(sprite.rotation_degrees.y, 0.0, flip_speed)
	else: 
		sprite.rotation_degrees.y = move_toward(sprite.rotation_degrees.y, 180.0, flip_speed)
			
	sprite.play(new_suffix + new_animation) #play animation
	
	
	
	#debugging section: checking x and y inputs
	print(input_dir.x)
	print(input_dir.y)
	





#Rotation function (ChatGPT)
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
	
